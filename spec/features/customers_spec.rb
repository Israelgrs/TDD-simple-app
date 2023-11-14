require 'rails_helper'

RSpec.feature 'Customers', type: :feature, js: true do
  it 'test naviagation for customers index' do
    visit(customers_path)
    page.save_screenshot('screenshot.png')
    expect(page).to have_current_path(customers_path)
  end
end
