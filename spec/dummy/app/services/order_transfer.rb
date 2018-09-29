class OrderTransfer < Rectify::Command
  def initialize(user)
    @user = user
  end

  def call
    return unless find_order

    transaction do
      delete_user_in_progress_orders
      add_order_to_user
    end
    broadcast(:ok)
  end

  private

  def find_order
    @order = ShoppingCart::Order.find_by_id(cookies.signed[:order_id])
  end

  def delete_user_in_progress_orders
    @user.orders.in_progress.destroy_all
  end

  def add_order_to_user
    @order.update(user: @user)
  end
end
