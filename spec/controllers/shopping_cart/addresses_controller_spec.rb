require 'rails_helper'

module ShoppingCart
  RSpec.describe AddressesController, type: :controller do
    routes { ShoppingCart::Engine.routes }

    describe 'PUT #update' do
      let(:address) { create(:address) }
      let(:user) { create(:user) }
      let(:valid_params) { attributes_for(:address, user_id: user.id) }

      context 'address already exist' do
        before do
          sign_in(address.user)
          put :update, params: { address: { user_id: address.user_id, type: address.type, zip: '123', country: 'Bookstoria' } }
        end

        it 'redirects to addresses#edit' do
          expect(response).to redirect_to(address_path)
        end

        it 'updates address' do
          address.reload
          expect(address.zip).to eq('123')
          expect(address.country).to eq('Bookstoria')
        end
      end

      context 'address does not exist yet' do
        before { sign_in(user) }

        context 'full valid params' do
          it 'creates new address in the database' do
            expect {
              put :update, params: { address: valid_params }
            }.to change(Address, :count).by(1)
          end

          it 'shows notice message' do
            put :update, params: { address: valid_params }
            expect(flash[:notice]).to eq I18n.t('notice.updated')
          end
        end

        context 'not full valid params' do
          it 'redirects to addresses#edit' do
            put :update, params: { address: { user_id: user.id, type: 'ShoppingCart::BillingAddress', first_name: 'John', last_name: 'Cena' } }
            expect(response).to render_template(:edit)
          end
        end
      end
    end
  end
end
