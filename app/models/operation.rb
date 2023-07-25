class Operation < ApplicationRecord
  has_and_belongs_to_many :customers

  validates :description, presence: { message: 'Description Required!' }
  validates :description, uniqueness: {
    message: lambda do |_object, data|
      "Operation '#{data[:value]}' duplicated!"
    end
  }
end
