class Wishlist < ApplicationRecord
    belongs_to :properties, optional: true
    belongs_to :renters, optional: true
    validates_uniqueness_of :renter_id, scope: :property_id

end
