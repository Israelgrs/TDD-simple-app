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
      @customer = create(:customer)
      sign_in @member
    end

    it 'with valid attributes' do
      customer_params = attributes_for(:customer, address: nil)
      expect { post :create, params: { customer: customer_params } }.not_to change(Customer, :count)
    end

    it 'with invalid attributes' do
      customer_params = attributes_for(:customer)
      expect { post :create, params: { customer: customer_params } }.to change(Customer, :count).by(1)
    end

    it { is_expected.to route(:get, '/customers').to(action: :index) }

    it 'Content-Type' do
      customer_params = attributes_for(:customer)
      post :create, format: :json, params: { customer: customer_params }
      expect(response.content_type).to match('application/json')
    end

    it 'flash notice' do
      customer_params = attributes_for(:customer)
      post :create, params: { customer: customer_params }
      expect(flash[:notice]).to match(/successfully created/)
    end

    it 'renders a show template' do
      get :show, params: { id: Customer.first.id }
      expect(response).to render_template(:show)
    end
  end
end
