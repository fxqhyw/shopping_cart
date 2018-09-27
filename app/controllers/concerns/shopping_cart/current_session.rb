module ShoppingCart::CurrentSession
  extend ActiveSupport::Concern

  included do
    def current_order
      return @current_order ||= current_user.orders.in_progress.first if user_signed_in?

      @current_order ||= ShoppingCart::Order.find_by_id(cookies.signed[:order_id])
    end
  end
end
