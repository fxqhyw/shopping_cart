module ShoppingCart
  class ConfirmOrder
    def initialize(order:, user:)
      @order = order
      @user = user
    end

    def call
      confirm_order
      send_thanks_email
      @order.decorate
    end

    private

    def confirm_order
      @order.total_price = @order.order_total
      @order.number = "#R#{Time.now.nsec}" + @order.id.to_s
      @order.confirm!
    end

    def send_thanks_email
      CheckoutMailer.with(user: @user, order: @order).complete_email.deliver_later
    end
  end
end
