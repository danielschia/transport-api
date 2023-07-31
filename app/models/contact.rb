class Contact < ApplicationRecord
  belongs_to :customer

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at customer_id description email id main telephone01 telephone02 updated_at]
  end
end
