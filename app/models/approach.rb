class Approach < ApplicationRecord
  belongs_to :Property, optional: true
  belongs_to :Renter, optional: true
  validates_uniqueness_of :renters_id, scope: :properties_id

end
