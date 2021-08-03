class PropertiesController < ApplicationController
   
    def new
       @agent =current_agent
       @properties=Property.new
        
       
    end
    def show
      @property=Property.find(params[:id])
      @renter =current_renter
      @review=Review.new()
      @review.property_id=@property.id
      @check= Rentedlist.where(property_id: @property.id).take
      @reviewslist=Review.where(property_id: @property.id).all
    end

    def addrented
      @adder=Rentedlist.new()
      @propertylist=Property.find(params[:id])
      @renter=current_renter
      @adder.renter_id=@renter.id
      @adder.property_id=@propertylist.id
      if @adder.save
        #flag updation for rented or not
        @property=Property.find(@propertylist.id)
        @property.update(flag: 1)
        redirect_to viewprop_path(@propertylist), notice: "an email has been sent to the respective owener , he will ge back you in short"
      end
    end
    def addwish
      @adder=Wishlist.new()
      @propertylist=Property.find(params[:id])
      @renter=current_renter
      @adder.renter_id=@renter.id
      @adder.property_id=@propertylist.id
      if @adder.valid?
        if @adder.save
        redirect_to viewprop_path(@propertylist), notice: "Added to Ur Wishlist"
        end
      else
        redirect_to viewprop_path(@propertylist), notice: "You had already added it to wishlist"

    end
  end
  def create
        
        @properties=Property.new(property_params)
        @properties.flag=0
        @agent=current_agent
        
        @properties.agent_id = @agent.id
        if @properties.valid?
             @properties.save
            redirect_to displayprop_path
        else
            flash.now[:messages] = @properties.errors.full_messages
              render :new
                
        end
       
        
    end
    def edit
        @property=Property.find(params[:id])
    end
    def update
        @property=Property.find(params[:id]) 
        if @property.update(params[:property].permit(:name,  :agent_id,:address, :city, :rent, :bedrooms,:description))
          redirect_to displayprop_path
        else
          render 'edit'
        end
    end
    def destroy
        @property = Property.find(params[:id])
        @property.destroy
       
        redirect_to displayprop_path
      end


      def showrented
        @renter=current_renter
        @properties=Rentedlist.where(renter_id: @renter.id)
        #@properties=Property.where(id: @properties.property_id).all
      end
      def showwish
        @renter=current_renter
        @properties=Wishlist.where(renter_id: @renter.id)
      end

      def remove
        @wish=Wishlist.find(params[:id])
        @wish.destroy
        redirect_to wishlistp_path,notice: "removed successfully"
      end
      def unrent
        @unrent=Rentedlist.find(params[:id])
        
        #flag updation for rented or not
        @property=Property.find(@unrent.property_id)
        @property.update(flag: 0)
        @unrent.destroy

        redirect_to rentedlistp_path,notice: "Unrented"
      end
      private
    def property_params
        params.require(:@properties).permit(:name,  :agent_id,:address, :city, :rent, :bedrooms,:description, images: [])

    end
end
