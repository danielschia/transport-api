class Operation < ApplicationRecord
  has_and_belongs_to_many :customers

  validates :description, presence: { message: 'Description Required!' }
  validates :description, uniqueness: {
    message: lambda do |_object, data|
      "Operation '#{data[:value]}' duplicated!"
    end
  }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at description id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['customers']
  end
end
