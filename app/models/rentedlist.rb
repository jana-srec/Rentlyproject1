class Rentedlist < ApplicationRecord
    belongs_to :properties, optional: true
    belongs_to :renters, optional: true
end
