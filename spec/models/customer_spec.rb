require 'rails_helper'

RSpec.describe Customer, type: :model do
  it '#formal_name' do
    customer = create(:user) # ou create(:customer)
    expect(customer.formal_name).to start_with('Sr. ')
  end

  it '#formal_name override attribute' do
    customer = build(:customer, name: 'Israel Gouveia')
    expect(customer.formal_name).to eq('Sr. Israel Gouveia')
  end

  it 'inheritance nested factories' do
    customer = create(:customer_vip)
    expect(customer.vip).to be_truthy
  end

  it 'Using attributes_for' do
    attrs = attributes_for(:customer)
    customer = Customer.create(attrs)
    expect(customer.formal_name).to start_with('Sr. ')
  end

  it 'Transient attributes' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it 'cliente masculino vip' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to be_truthy
  end

  it 'cliente masculino' do
    customer = create(:customer_male)
    expect(customer.gender).to eq('M')
  end

  it 'cliente feminino' do
    customer = create(:customer_female)
    expect(customer.gender).to eq('F')
  end

  it 'cliente feminino default' do
    customer = create(:customer_female_default)
    expect(customer.gender).to eq('F')
    expect(customer.vip).to be_falsey
  end

  it { expect { create(:customer) }.to change { Customer.all.size }.by(1) }
end
