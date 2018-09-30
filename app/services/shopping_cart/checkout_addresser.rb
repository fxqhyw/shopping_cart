module ShoppingCart
  class CheckoutAddresser
    def initialize(params:, type:)
      @params = params
      @type = type
    end

    def call
      address = find_address || new_address
      address.attributes = address_params
      address
    end

    private

    def find_address
      return BillingAddress.find_by(order_id: address_params[:order_id]) if @type == :billing

      ShippingAddress.find_by(order_id: address_params[:order_id])
    end

    def new_address
      return BillingAddress.new if @type == :billing

      ShippingAddress.new
    end

    def address_params
      @params.require(@type).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :order_id)
    end
  end
end
