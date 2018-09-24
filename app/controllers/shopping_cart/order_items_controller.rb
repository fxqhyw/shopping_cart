module ShoppingCart
  class OrderItemsController < ApplicationController
    before_action :order_item, only: %i[update destroy]

    def create
      CreateOrderItem.call(permited_params) do
        on(:ok) { render :create }
      end
    end

    def update
      @order_item.update(quantity: params[:quantity])
    end

    def destroy
      @order_item.destroy
    end

    private

    def permited_params
      params.permit(:quantity, :book_id)
    end

    def order_item
      @order_item = OrderItem.find(params[:id])
    end
  end
end
