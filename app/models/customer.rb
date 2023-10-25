class Customer < ApplicationRecord
  has_many :orders

  validates :address, presence: true

  def formal_name
    "Sr. #{name}"
  end
end
