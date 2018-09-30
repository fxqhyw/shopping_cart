module ShoppingCart
  class CheckoutStepper < Rectify::Command
    def initialize(steps:, step:, order:, user:, edit: false)
      @steps = steps
      @current_step = step
      @order = order
      @user = user
      @editable = edit
    end

    def call
      return broadcast(:empty_cart) if empty_cart?

      showable_step
      return broadcast(:invalid) if @current_step == @step

      broadcast(:ok, @step)
    end

    private

    def showable_step
      return @step = @current_step if @editable && completed?(@current_step)

      @steps.reverse_each do |step|
        @step = step unless completed?(step)
      end
    end

    def completed?(step)
      {
        login: @user,
        address: @order.billing_address,
        delivery: @order.delivery,
        payment: @order.credit_card,
        confirm: @order.in_queue?
      }[step]
    end

    def empty_cart?
      return true unless @order

      @order.order_items.empty?
    end
  end
end
