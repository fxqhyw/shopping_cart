module ShoppingCart
  module OrdersHelper
    def filter_orders_title
      return I18n.t("orders.#{request.GET[:filter]}") if request.GET[:filter]

      I18n.t('button.all')
    end

    def client_name(address)
      address.first_name + ' ' + address.last_name if address
    end

    def secret_card_number(number)
      '**** **** **** ' + number if number
    end
  end
end
