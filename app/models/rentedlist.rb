class Rentedlist < ApplicationRecord
    belongs_to :properties
    belongs_to :renters
end
