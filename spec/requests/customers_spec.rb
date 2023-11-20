require 'rails_helper'

describe 'CustomersController', type: :request do
  it 'Json Schema' do
    get '/customers/1.json'
    p JSON.parse(response.body)['id'].class
    expect(response).to match_response_schema('customer')
  end

  it 'index route - OK' do
    get customers_path
    expect(response).to have_http_status(200)
  end

  it 'Json response  for index in Json format' do
    get '/customers.json'
    expect(response.body).to include_json(
      [
        id: /\d/,
        name: (be_an String),
        email: (be_kind_of String)
      ]
    )
  end

  it 'Json response for Show in JSON format - JSON matcher' do
    get '/customers/1.json'
    expect(response.body).to include_json(
      id: /\d/
    )
  end

  it 'Json response for Show in JSON format - Rspec puro' do
    get '/customers/1.json'
    response_body = JSON.parse(response.body)
    expect(response_body.fetch('id')).to be(1)
    expect(response_body.fetch('name')).to be_an(String)
    expect(response_body.fetch('email')).to be_an(String)
  end


  it 'Creates a Customer using Json Format' do
    member = create(:member)
    login_as(member, scope: :member)

    headers = { 'Accept': 'application/json' }
    customer_params = attributes_for(:customer)
    post '/customers.json', params: { customer: customer_params }, headers: headers

    expect(response.body).to include_json(
      id: /\d/,
      name: customer_params.fetch(:name),
      email: customer_params.fetch(:email)
    )
  end

  it 'Updates a Customer using Json Format' do
    member = create(:member)
    login_as(member, scope: :member)

    headers = { 'Accept': 'application/json' }
    customer = Customer.all.sample
    customer.name += ' - ATUALIZADO'
    patch "/customers/#{customer.id}.json", params: { customer: customer.attributes }, headers: headers
    expect(response.body).to include_json(
      id: customer.id,
      name: customer.name,
      email: customer.email
    )
  end

  it 'Deletes a Customer using Json Format' do
    member = create(:member)
    login_as(member, scope: :member)

    headers = { 'Accept': 'application/json' }
    customer = Customer.all.sample
    expect { delete "/customers/#{customer.id}.json", headers: headers }.to change(Customer, :count).by(-1)
    expect(response).to have_http_status(:no_content)
  end
end