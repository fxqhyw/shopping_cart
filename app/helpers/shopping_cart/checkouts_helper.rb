module ShoppingCart
  module CheckoutsHelper
    def active_step(current_step)
      'active' if current_step == step
    end

    def address_error?(field:, tag:)
      return @billing.errors.include?(field) if billing_address?(tag)

      @shipping.errors.include?(field) if shipping_address?(tag)
    end

    def address_error_message(field:, tag:)
      return @billing.errors[field].to_sentence if billing_address?(tag)

      @shipping.errors[field].to_sentence if shipping_address?(tag)
    end

    def address_saved_value(field:, tag:)
      return order_address_field('billing', field) || user_address_field('billing', field) || inputed_address_field('billing', field) if hide_address_fields?(tag)

      order_address_field(tag, field) || user_address_field(tag, field) || inputed_address_field(tag, field)
    end

    def hide_address_fields?(tag)
      tag == 'shipping' && current_page?('/checkouts/address?edit=true') && !current_order.shipping_address
    end

    def checked_delivery?(delivery_id)
      current_order.delivery_id == delivery_id
    end

    def card_error?(field)
      @credit_card.errors.include?(field) if @credit_card
    end

    def card_error_message(field)
      @credit_card.errors[field].to_sentence if @credit_card
    end

    def card_saved_value(field)
      current_order.credit_card.try(field) || @credit_card.try(field)
    end

    def client_name(address)
      address.first_name + ' ' + address.last_name if address
    end

    def secret_card_number(number)
      '**** **** **** ' + number if number
    end

    private

    def billing_address?(tag)
      @billing && tag == 'billing'
    end

    def shipping_address?(tag)
      @shipping && tag == 'shipping'
    end

    def user_address_field(tag, field)
      return current_user.billing_address.try(field) if tag == 'billing'

      current_user.shipping_address.try(field) if tag == 'shipping'
    end

    def order_address_field(tag, field)
      return current_order.billing_address.try(field) if tag == 'billing'

      current_order.shipping_address.try(field) if tag == 'shipping'
    end

    def inputed_address_field(tag, field)
      return @billing.try(field) if tag == 'billing'

      @shipping.try(field) if tag == 'shipping'
    end
  end
end
