require 'rails_helper'

RSpec.feature 'Cart page', type: :feature do
  let(:coupon) { create(:coupon) }

  before do
    @order_item = create(:order_item)
    my_jar = ActionDispatch::Request.new(Rails.application.env_config).cookie_jar
    my_jar.signed[:order_id] = @order_item.order_id
    create_cookie(:order_id, my_jar[:order_id])
    visit('/cart')
  end

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
