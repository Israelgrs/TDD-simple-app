class Product < ApplicationRecord
  belongs_to :category

  validates :description, :price, :category, presence: true

  def full_description
    "#{description} - #{price}"
  end
end
