module ShoppingCart
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_order

    private

    def current_order
      return @current_order ||= current_user.orders.in_progress.first if user_signed_in?

      @current_order ||= Order.find_by_id(cookies.signed[:order_id])
    end
  end
end
