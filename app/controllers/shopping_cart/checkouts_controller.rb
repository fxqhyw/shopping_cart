require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class CheckoutsController < ApplicationController
    include Wicked::Wizard
    include Rectify::ControllerHelpers

    before_action :authenticate_user!, only: :update

    steps :login, :address, :delivery, :payment, :confirm

    def show
      CheckoutStepper.call(steps: steps, step: step, edit: params[:edit], order: current_order, user: current_user) do
        on(:empty_cart) { redirect_to cart_path, alert: I18n.t('notice.empty_cart') }
        on(:invalid) { render_wizard }
        on(:ok) do |step|
          jump_to(step)
          render_wizard
        end
      end
    end

    def update
      CheckoutUpdater.call(step: step, params: params, order: current_order, user: current_user) do
        on(:only_billing_address) do |billing|
          expose(billing: billing)
          render_wizard billing
        end
        on(:both_addresses) do |billing, shipping|
          expose(billing: billing, shipping: shipping)
          render_wizard shipping
        end
        on(:invalid_addresses) do |billing, shipping|
          expose(billing: billing, shipping: shipping)
          render :address
        end
        on(:delivery_ok) { |order| render_wizard order }
        on(:payment_ok) do |credit_card|
          expose(credit_card: credit_card)
          render_wizard credit_card
        end
        on(:confirm_ok) do |placed_order|
          expose(placed_order: placed_order)
          render :complete
        end
      end
    end
  end
end
