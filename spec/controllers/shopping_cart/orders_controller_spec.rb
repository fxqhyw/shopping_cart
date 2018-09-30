require 'rails_helper'

module ShoppingCart
  RSpec.describe OrdersController, type: :controller do
    routes { ShoppingCart::Engine.routes }

    let(:order) { create(:order) }

    before { sign_in(order.user) }

    describe 'GET #index' do
      before { get :index }

      it 'renders :index remplate' do
        expect(response).to render_template(:index)
      end

      it 'assigns @orders' do
        expect(assigns(:orders)).not_to be_nil
      end
    end

    describe 'GET #show' do
      before { get :show, params: { id: order.id } }

      it 'renders :show template' do
        expect(response).to render_template(:show)
      end

      it 'assigns requested order to @order' do
        expect(assigns(:order)).to eq(order)
      end
    end
  end
end
