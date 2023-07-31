class Customer < ApplicationRecord
  has_many :facilities, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :operations, dependent: :destroy

  has_and_belongs_to_many :operations, dependent: :destroy
  attribute :operation_ids, dependent: :destroy

  validates :customer_name, presence: { message: 'Customer name required!' }
  validates :tax_id, length: { maximum: 14 }, presence: { message: 'Tax id required!' }
  validates :state_registration, length: { maximum: 12 }, presence: { message: 'State Registration required!' }
  validates :fantasy_name, uniqueness: {
    message: lambda do |_object, data|
               "Fantasy Name '#{data[:value]}' already exists!"
             end
  }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at customer_name fantasy_name id state_registration status tax_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[contacts facilities operations]
  end
end
