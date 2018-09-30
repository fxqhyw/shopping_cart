module ShoppingCart
  class OrdersFilter
    FILTERS = {
      'in_queue' => :in_queue,
      'in_delivery' => :in_delivery,
      'delivered' => :delivered,
      'canceled' => :canceled
    }.freeze

    def initialize(orders:, params:)
      @orders = orders
      @params = params
    end

    def call
      return send(FILTERS[@params[:filter]]) if FILTERS[@params[:filter]]

      @orders
    end

    private

    def in_queue
      @orders.in_queue
    end

    def in_delivery
      @orders.in_delivery
    end

    def delivered
      @orders.delivered
    end

    def canceled
      @orders.canceled
    end
  end
end
