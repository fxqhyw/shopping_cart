module ShoppingCart
  class OrderDecorator < Draper::Decorator
    delegate_all

    def status_string
      I18n.t("orders.#{object.status}")
    end

    def created_date
      object.created_at.strftime('%Y-%m-%d')
    end
  end
end
