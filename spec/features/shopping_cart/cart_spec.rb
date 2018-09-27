require 'rails_helper'

RSpec.feature 'Cart page', type: :feature do
  before do
    @order_item = create(:order_item)
    my_jar = ActionDispatch::Request.new(Rails.application.env_config).cookie_jar
    my_jar.signed[:order_id] = @order_item.order_id
    create_cookie(:order_id, my_jar[:order_id])
    visit('/cart')
  end

  context 'update cart' do
    let(:quantity_input) { find("#quantity_input_#{@order_item.id}") }
    let(:plus) { find("#plus_#{@order_item.id}") }
    let(:minus) { find("#minus_#{@order_item.id}") }

    scenario 'change order item quantity', js: true do
      expect(quantity_input).to have_content('1')
      plus.click
      wait_for_ajax
      expect(quantity_input).to have_content('2')
      minus.click
      wait_for_ajax
      expect(quantity_input).to have_content('1')
    end

    scenario 'can not decrease item quantity to less than 1', js: true do
      expect(quantity_input).to have_content('1')
      3.times do
        minus.click
        wait_for_ajax
      end
      expect(quantity_input).to have_content('1')
    end
  end

  context 'Coupon', js: true do
    let(:coupon) { create(:coupon) }

    scenario 'apply valid coupon' do
      fill_in I18n.t('cart.coupon'), with: coupon.code
      click_button I18n.t('cart.apply_coupon')
      expect(page).to have_content(coupon.discount)
    end

    scenario 'show error when try to apply invalid coupon' do
      fill_in I18n.t('cart.coupon'), with: 'fake code'
      click_button I18n.t('cart.apply_coupon')
      expect(page).not_to have_content(coupon.discount)
    end
  end
end
