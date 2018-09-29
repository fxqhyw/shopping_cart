require 'rails_helper'
require 'ffaker'

RSpec.feature 'Checkout', type: :feature do
  let(:user) { create(:user) }

  scenario 'try to go to checkout path with empty cart' do
    visit('/checkouts')
    expect(page).to have_current_path('/cart')
    expect(page).to have_content I18n.t('notice.empty_cart')
  end

  describe 'login step' do
    before do
      order_item = create(:order_item)
      my_jar = ActionDispatch::Request.new(Rails.application.env_config).cookie_jar
      my_jar.signed[:order_id] = order_item.order_id
      create_cookie(:order_id, my_jar[:order_id])
      visit('/checkouts')
    end

    scenario 'login step with quick register' do
      expect(page).to have_current_path('/checkouts/login')
      within '#quick_register_form' do
        fill_in 'Enter Email', with: 'myemail@gmail.com'
        click_button I18n.t('checkout.continue')
      end
      expect(page).to have_current_path('/checkouts/address')
    end

    scenario 'login with password' do
      expect(page).to have_current_path('/checkouts/login')
      within '#login_form' do
        fill_in 'Enter Email', with: user.email
        fill_in 'Password', with: 'qwerty123'
        click_button I18n.t('checkout.login_with_password')
      end
      expect(page).to have_current_path('/checkouts/address')
    end
  end

  describe 'other steps' do
    let(:use_billing_checkbox) { page.find('.checkbox-icon') }

    before do
      create_list(:delivery, 3)
      @address = create(:address, user: user)
      create(:order_item, order: create(:order, user: user))
      login_as(user, scope: :user)
      visit '/checkouts'
    end

    scenario 'try to pass address step with invalid data' do
      expect(page).to have_current_path('/checkouts/address')
      within '#shipping' do
        fill_in 'First Name', with: ''
        fill_in 'Last Name', with: '123'
        fill_in 'Address', with: '&*'
        fill_in 'City', with: '34'
        fill_in 'Zip', with: 'zip?'
        fill_in 'Phone', with: 'No Phone'
      end
      click_button I18n.t('checkout.save_and_continue')
      expect(page).to have_css('div.has-error')
      expect(page).to have_content("can't be blank and must consist of only letters")
      expect(page).to have_content('must consist of only letters')
      expect(page).to have_content('must consist of letters, digits and ’,’, ‘-’, ‘ ’ only, no special symbols')
      expect(page).to have_content('must consist of only digits')
      expect(page).to have_content("must starts with '+' and consist of only digits")
      expect(page).to have_current_path('/checkouts/address')
    end

    scenario 'can change my mind about use billing address on address step', js: true do
      3.times { use_billing_checkbox.trigger('click') }
      click_button I18n.t('checkout.save_and_continue')
      expect(page).to have_current_path('/checkouts/delivery')
    end

    scenario 'can change my mind about use billing address after passing address step', js: true do
      expect(page).to have_current_path('/checkouts/address')
      click_button I18n.t('checkout.save_and_continue')
      expect(page).to have_css('div.has-error')
      use_billing_checkbox.trigger('click')
      click_button I18n.t('checkout.save_and_continue')
      expect(page).to have_current_path('/checkouts/delivery')
      visit '/checkouts/address?edit=true'
      expect(find('#use_billing', visible: :hidden)).to be_checked
      expect(page).to have_css('#shipping', visible: :hidden)
      use_billing_checkbox.trigger('click')
      expect(find('#use_billing', visible: :hidden)).not_to be_checked
    end

    scenario 'pass all steps from address to complete', js: true do
      expect(page).to have_current_path('/checkouts/address')
      expect(page).to have_field('First Name', with: @address.first_name)
      expect(page).to have_field('Last Name', with: @address.last_name)
      expect(page).to have_field('Address', with: @address.address)
      expect(page).to have_field('City', with: @address.city)
      expect(page).to have_field('Zip', with: @address.zip)
      expect(page).to have_field('Phone', with: @address.phone)
      use_billing_checkbox.trigger('click')
      click_button I18n.t('checkout.save_and_continue')
      expect(page).to have_current_path('/checkouts/delivery')
      find('.radio-icon', match: :first).trigger('click')
      click_button I18n.t('checkout.save_and_continue')
      expect(page).to have_current_path('/checkouts/payment')
      fill_in 'Card Number', with: '12345678912312'
      fill_in 'Name on Card', with: 'Loker Lucker'
      fill_in 'MM / YY', with: '11/22'
      fill_in 'CVV', with: '123'
      click_button I18n.t('checkout.save_and_continue')
      expect(page).to have_current_path('/checkouts/confirm')
      find('#edit_address_link').click
      expect(page).to have_current_path('/checkouts/address?edit=true')
      expect(page).to have_field('Zip', with: @address.zip)
      within '#billing' do
        fill_in 'Zip', with: '321'
      end
      use_billing_checkbox.trigger('click')
      click_button('Save and Continue')
      expect(page).to have_current_path('/checkouts/confirm')
      expect(page).to have_content(@address.first_name)
      expect(page).to have_content(@address.last_name)
      expect(page).to have_content(@address.address)
      expect(page).to have_content(@address.city)
      expect(page).to have_content(@address.phone)
      expect(page).to have_content('11/22')
      expect(page).to have_content('**** **** **** 2312')
      click_link I18n.t('checkout.place_order')
    end
  end
end
