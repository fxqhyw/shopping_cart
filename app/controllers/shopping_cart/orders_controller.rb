require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    def index
      @orders = OrdersFilter.new(orders: current_user.orders.placed, params: params).call.decorate
    end

    def show; end
  end
end
