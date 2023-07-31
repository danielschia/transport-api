class Facility < ApplicationRecord
  belongs_to :customer, optional: true

  validates :city, presence: true
  validates :state, presence: { message: 'State required!' }
  validates :cep, presence: { message: 'CEP required!' }
  validates :country, presence: { message: 'Country required!' }
  validates :description, presence: { message: 'Description required!' }
  validates :number, presence: { message: 'Number required!' }

  def self.ransackable_attributes(_auth_object = nil)
    %w[cep city complement country created_at customer_id description id number state
       updated_at]
  end
end
