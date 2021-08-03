class ReviewController < ApplicationController
    
    #Saving the Reviews to the table
    def create
        @review=Review.new(review_params)
        @review.renter_id=current_renter.id
       
       # puts "#{@review.property_id}"
        @prop = Property.where(id: @review.property_id).take
        if @review.save
            redirect_to viewproperty_path(@prop)
        end
    end

    
    private
    def review_params
        params.require(:@reviews).permit(:reviews,:rating,:property_id)
    end
end
