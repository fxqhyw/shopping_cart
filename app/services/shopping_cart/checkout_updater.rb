module ShoppingCart
  class CheckoutUpdater < Rectify::Command
    STEPS = {
      address: :update_address,
      delivery: :update_delivery,
      payment: :update_credit_card,
      confirm: :confirm_order
    }.freeze

    def initialize(step:, params:, order:, user:)
      @step = step
      @params = params
      @order = order
      @user = user
    end

    def call
      send(STEPS[@step]) if STEPS[@step]
    end

    private

    def update_address
      billing = CheckoutAddresser.new(params: @params, type: :billing).call
      shipping = CheckoutAddresser.new(params: @params, type: :shipping).call
      return broadcast(:only_billing_address, billing) if @params[:use_billing]['true'] == '1'

      return broadcast(:both_addresses, billing, shipping) if billing.save

      shipping.save
      broadcast(:invalid_addresses, billing, shipping)
    end

    def update_delivery
      @order.delivery_id = @params[:delivery_id] if @params[:delivery_id]
      broadcast(:delivery_ok, @order)
    end

    def update_credit_card
      credit_card = CheckoutPayment.new(@params).call
      broadcast(:payment_ok, credit_card)
    end

    def confirm_order
      placed_order = ConfirmOrder.new(order: @order, user: @user).call
      broadcast(:confirm_ok, placed_order)
    end
  end
end
