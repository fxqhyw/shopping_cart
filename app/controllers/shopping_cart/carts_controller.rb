require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class CartsController < ApplicationController
    def show; end

    def update
      AddCoupon.call(code: params[:coupon_code], order: current_order) do
        on(:ok) { redirect_to cart_path, notice: I18n.t('notice.coupon_added') }
        on(:invalid) { redirect_to cart_path, alert: I18n.t('notice.coupon_invalid') }
      end
    end
  end
end
