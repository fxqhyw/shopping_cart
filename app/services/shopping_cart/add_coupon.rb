module ShoppingCart
  class AddCoupon < Rectify::Command
    def initialize(code:, order:)
      @code = code
      @order = order
    end

    def call
      coupon = Coupon.find_by_code(@code)
      return broadcast(:invalid) unless coupon

      @order.update(coupon: coupon)
      broadcast(:ok)
    end
  end
end
