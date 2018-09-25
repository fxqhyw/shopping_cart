require 'rails_helper'

module ShoppingCart
  RSpec.describe CheckoutsController, type: :controller do
    routes { ShoppingCart::Engine.routes }

    describe 'GET #show' do
      let(:order) { create(:order) }

      context 'cart is not empty' do
        %i[login address delivery payment confirm].each do |step|
          it "renders #{step} template" do
            allow_any_instance_of(CheckoutStepper).to receive(:empty_cart?) { false }
            allow_any_instance_of(ApplicationController).to receive(:current_order) { order }
            allow_any_instance_of(CheckoutStepper).to receive(:showable_step) { step }
            get :show, params: { id: step }
            expect(response).to render_template(step)
            expect(response).to have_http_status 200
          end
        end
      end

      context 'cart is empty' do
        it 'redirects to cart path if cart is empty' do
          allow_any_instance_of(CheckoutStepper).to receive(:empty_cart?) { true }
          get :show, params: { id: :address }
          expect(response).to redirect_to(cart_path)
        end
      end
    end

    describe 'PUT #update' do
      let(:user) { create(:user) }
      let(:order) { create(:order) }
      let(:valid_address) { attributes_for(:address, order_id: order.id) }
      let(:invalid_address) { attributes_for(:address, zip: 'qwerty', phone: 'no phone(', user_id: user.id) }
      before { sign_in(user) }

      describe 'address step' do
        context 'valid params' do
          context 'without use billing' do
            it 'saves order addresses' do
              expect {
                put :update, params: { id: :address, use_billing: { 'true': '0' },
                                      billing: valid_address, shipping: valid_address }
              }.to change(Address, :count).by(2)
            end

            it 'redirects to delivery step' do
              put :update, params: { id: :address, use_billing: { 'true': '0' },
                                    billing: valid_address, shipping: valid_address }
              expect(response).to redirect_to('/checkouts/delivery')
            end
          end

          context 'with use billing' do
            it 'saves only billing address' do
              expect {
                put :update, params: { id: :address, use_billing: { 'true': '1' },
                                      shipping: invalid_address, billing: valid_address }
              }.to change(Address, :count).by(1)
            end

            it 'redirects to delivery step' do
              put :update, params: { id: :address, use_billing: { 'true': '1' },
                                    billing: valid_address, shipping: valid_address }
              expect(response).to redirect_to('/checkouts/delivery')
            end
          end
        end

        context 'invalid params' do
          it 'does not save addresses' do
            expect {
              put :update, params: { id: :address, use_billing: { 'true': '0' },
                                    billing: invalid_address, shipping: invalid_address }
            }.not_to change(Address, :count)
          end

          it 'renders address template' do
            put :update, params: { id: :address, use_billing: { 'true': '0' },
                                  billing: invalid_address, shipping: invalid_address }
            expect(response).to render_template(:address)
          end
        end
      end

      describe 'delivery step' do
        context 'valid params' do
          let(:delivery) { create(:delivery) }
          before do
            @order = create(:order, user: user)
            put :update, params: { id: :delivery, delivery_id: delivery.id }
          end

          it 'saves delivery to user order' do
            @order.reload
            expect(@order.delivery_id).to eq(delivery.id)
          end

          it 'redirects to payment step' do
            expect(response).to redirect_to('/checkouts/payment')
          end
        end

        context 'invalid params' do
          it 'does not saves delivery to order' do
            @order = create(:order, user: user)
            put :update, params: { id: :delivery }
            @order.reload
            expect(@order.delivery).to be_nil
          end
        end
      end

      describe 'payment step' do
        context 'valid params' do
          let(:order) { create(:order) }
          let(:valid_card) { attributes_for(:credit_card, order_id: order.id) }

          it 'saves credit card to order' do
            expect {
              put :update, params: { id: :payment, credit_card: valid_card }
            }.to change(CreditCard, :count).by(1)
          end

          it 'redirects to confirm step' do
            put :update, params: { id: :payment, credit_card: valid_card }
            expect(response).to redirect_to('/checkouts/confirm')
          end
        end
        context 'invalid params' do
          let(:invalid_card) { attributes_for(:credit_card, cvv: 'cvc', number: 'qwerty') }

          it 'does not save card' do
            expect {
              put :update, params: { id: :payment, credit_card: invalid_card }
            }.not_to change(CreditCard, :count)
          end

          it 'renders payment template' do
            put :update, params: { id: :payment, credit_card: invalid_card }
            expect(response).to render_template(:payment)
          end
        end
      end

      describe 'confirm step' do
        before { @order = create(:order, user: user) }

        it 'assigns order total price' do
          put :update, params: { id: :confirm }
          @order.reload
          expect(@order.total_price).to eq(@order.order_total)
        end

        it 'assigns order number' do
          put :update, params: { id: :confirm }
          @order.reload
          expect(@order.number).not_to be_nil
        end

        it 'changes order status to in_queue' do
          expect {
            put :update, params: { id: :confirm }
            @order.reload
          }.to change{ @order.status }.from('in_progress').to('in_queue')
        end

        it 'renders complete template' do
          put :update, params: { id: :confirm }
          expect(response).to render_template(:complete)
        end

        it 'sends complete email' do
          expect {
            put :update, params: { id: :confirm }
          }.to have_enqueued_job.on_queue('mailers')
        end
      end
    end
  end
end
