class RenterController < ApplicationController
    def show
        @propertylist=Property.all
        @renter=current_renter
    end
end
