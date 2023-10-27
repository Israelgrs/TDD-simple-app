require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  context 'As a guest' do
    it '#index responds successfully' do
      get :index
      expect(response).to be_successful
    end

    it '#index responds with a 200 status code' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it '#show responds with a 200 status code' do
      get :show, params: { id: Customer.first.id }
      expect(response).to have_http_status(:found)
    end
  end

  context 'as a Logged Member' do
    before do
      @member = create(:member)
      sign_in @member
    end

    it 'with valid attributes' do
      customer_params = attributes_for(:customer)
      expect { post :create, params: { customer: customer_params } }.to change(Customer, :count).by(1)
    end

    it 'renders a show template' do
      get :show, params: { id: Customer.first.id }
      expect(response).to render_template(:show)
    end
  end
end
