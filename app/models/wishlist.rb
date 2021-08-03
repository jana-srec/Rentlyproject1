class Wishlist < ApplicationRecord
    belongs_to :properties, optional: true
    belongs_to :renters, optional: true
    validates :property_id, uniqueness: true, on: :create
end
