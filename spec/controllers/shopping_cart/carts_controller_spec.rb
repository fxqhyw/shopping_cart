require 'rails_helper'

module ShoppingCart
  RSpec.describe CartsController, type: :controller do
    routes { ShoppingCart::Engine.routes }

    describe 'GET #show' do
      before { get :show }

      it 'renders :show template' do
        expect(response).to render_template(:show)
      end
    end

    describe 'PUT #update' do
      context 'valid coupon' do
        let(:order) { create(:order) }
        let(:coupon) { create(:coupon) }

        before do
          cookies.signed[:order_id] = order.id
          put :update, params: { coupon_code: coupon.code }
        end

        it 'redirects to carts#show' do
          expect(response).to redirect_to(cart_path)
        end

        it 'updates order in the database' do
          order.reload
          expect(order.coupon_id).to eq(coupon.id)
        end

        it 'shows success message' do
          expect(flash[:notice]).to eq I18n.t('notice.coupon_added')
        end
      end

      context 'invalid coupon' do
        before { put :update, params: { coupon_code: 'fake' } }

        it 'redirects to carts#show' do
          expect(response).to redirect_to(cart_path)
        end

        it 'shows error message' do
          expect(flash[:alert]).to eq I18n.t('notice.coupon_invalid')
        end
      end
    end
  end
end
