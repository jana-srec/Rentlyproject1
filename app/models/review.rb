class Review < ApplicationRecord
    belongs_to :properties, optional: true
    belongs_to :renter, optional: true
    validates :property_id, uniqueness: true, on: :create
end
