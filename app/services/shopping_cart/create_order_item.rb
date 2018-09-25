module ShoppingCart
  class CreateOrderItem < Rectify::Command
    def initialize(params)
      @params = params
    end

    def call
      create_order unless current_order
      find_order_item ? update_order_item_quantity : create_new_order_item
      broadcast(:ok)
    end

    private

    def create_order
      return current_user.orders.create if user_signed_in?

      order = Order.create
      cookies.signed[:order_id] = { value: order.id, expires: 1.month.from_now }
    end

    def find_order_item
      @order_item = current_order.order_items.find_by(product_id: @params[:product_id])
    end

    def update_order_item_quantity
      @order_item.quantity += @params[:quantity].to_i
      @order_item.save
    end

    def create_new_order_item
      current_order.order_items.create(@params)
    end
  end
end
