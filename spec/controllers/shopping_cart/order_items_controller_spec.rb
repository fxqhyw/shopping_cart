require 'rails_helper'

module ShoppingCart
  RSpec.describe OrderItemsController, type: :controller do
    routes { ShoppingCart::Engine.routes }

    let(:order_item) { create(:order_item) }

    describe 'POST #create' do
      context 'order item already exist' do
        it 'increases order item quantity' do
          cookies.signed[:order_id] = order_item.order.id
          post :create, xhr: true, params: { product_id: order_item.product_id, quantity: 1 }
          order_item.reload
          expect(order_item.quantity).to eq(2)
        end
      end

      context 'order item does not yet exist' do
        it 'creates new order item in the database' do
          product = create(:product)
          expect {
            post :create, xhr: true, params: { product_id: product.id, quantity: 4 }
          }.to change(OrderItem, :count).by(1)
        end
      end
    end

    describe 'PUT #update' do
      it 'changes order item quantity' do
        put :update, xhr: true, params: { id: order_item.id, quantity: 3 }
        order_item.reload
        expect(order_item.quantity).to eq(3)
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes order item from the database' do
        delete :destroy, xhr: true, params: { id: order_item.id }
        expect(OrderItem.exists?(order_item.id)).to be_falsy
      end
    end
  end
end
