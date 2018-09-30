module ShoppingCart
  class CheckoutPayment
    def initialize(params)
      @params = params
    end

    def call
      credit_card = CreditCard.find_by(order_id: credit_card_params[:order_id]) || CreditCard.new
      credit_card.attributes = credit_card_params
      credit_card.number = credit_card_params[:number][-4, 4]
      credit_card
    end

    private

    def credit_card_params
      @params.require(:credit_card).permit(:number, :name, :expiration_date, :order_id)
    end
  end
end
