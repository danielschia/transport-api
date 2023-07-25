class Customer < ApplicationRecord
  has_many :facilities, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :operations, dependent: :destroy

  has_and_belongs_to_many :operations, dependent: :destroy
  attribute :operation_ids, dependent: :destroy

  validates :customer_name, presence: { message: 'Customer name required!' }
  validates :tax_id, length: { maximum: 14 }
  validates :state_registration, length: { maximum: 12 }
  validates :fantasy_name, uniqueness: {
    message: lambda do |_object, data|
               "Fantasy Name '#{data[:value]}' already exists!"
             end
  }
end
