class Customer < ApplicationRecord
  has_many :facilities
  has_many :contacts
end
