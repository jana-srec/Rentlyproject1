class PropertiesController < ApplicationController
    #for creating a new agent
    def new
       @agent =current_agent
       @properties=Property.new
    end

    #display property 
    def show
      @property=Property.find(params[:id])
      @renter =current_renter
      @review=Review.new()
      @review.property_id=@property.id
      # to check whether the property is rented or not in the view side
      @check= Rentedlist.where(property_id: @property.id).take
      @reviewslist=Review.where(property_id: @property.id).all
      #for approachlist to check if it is already approached by the current renter or not
      @approachflag=0
      @appr=Approach.where(renters_id:@renter.id).all
      #loop through the renters to find whether the propertyis already approached or not
      @appr.each do |prp|
          if prp.properties_id == @property.id
          @approachflag=1
          puts "#{@approachflag}"
          break
        end
        #ending the loop
      end
    end


    # Add a particular property in rented list and sending email to Agent
    def addrented
      @adder=Rentedlist.new()
      @approach=Approach.find(params[:id])
      @adder.renter_id=@approach.renters_id
      @adder.property_id=@approach.properties_id
      @property=Property.find(@approach.properties_id)
      @currentflag=0;
      if @adder.save
        # getting agent, property, renters object for sending email
        @agent=current_agent
        @renter= Renter.find(@approach.renters_id)
        #flag updation for rented or not
        @property.update(flag: 1)
        #sending email to renters that Agent has accepted his approach
        UserMailer.propertyrented(@renter,@agent,@property).deliver


       # sending email to those who are approached as it was allocated for someone except the allocated renter
       @approach.destroy
         @check=Approach.where(properties_id: @property.id).all
         @check.each do |obj|
         @renter=Renter.find(obj.renters_id)
         @agent=Agent.find(@property.agent_id)
          UserMailer.propertybooked(@renter,@agent,@property).deliver_now
         end


        redirect_to viewapproach_path(@property), notice: "An email has been sent to the respective Renter regarding your acceptance , he will ge back you in short"
      else
      redirect_to viewapproach_path(@property), notice: "Sorry you have already accepted this renter"
      end
    end

    #Adding a particular property to wishlist
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

    #Adding a new property
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


    #Modifiying the existing property
    def edit
        @property=Property.find(params[:id])
    end



    #updating the particular modification to that property
    def update
        @property=Property.find(params[:id]) 
        if @property.update(params[:property].permit(:name,  :agent_id,:address, :city, :rent, :bedrooms,:description))
          redirect_to displayprop_path
        else
          render 'edit'
        end
    end



    #Removing a property from the propertytable
    def destroy
        @property = Property.find(params[:id])
        @property.destroy
        redirect_to displayprop_path
     end



    #Display the property from Rentedlist table
      def showrented
        @renter=current_renter
        @properties=Rentedlist.where(renter_id: @renter.id)
        #@properties=Property.where(id: @properties.property_id).all
      end



     #Display the property from Showlist table 
      def showwish
        @renter=current_renter
        @properties=Wishlist.where(renter_id: @renter.id)
      end


      #Removing a property from wishlist
      def remove
        @wish=Wishlist.find(params[:id])
        @wish.destroy
        redirect_to wishlistp_path,notice: "removed successfully"
      end


      #Removing a property from the Rentedlist and replace the flag to 0 and mail
      #to those who added to wishlit as this property
      def unrent
        @unrent=Rentedlist.find(params[:id])
        #flag updation for rented or not
        @property=Property.find(@unrent.property_id)
        @property.update(flag: 0)
        @check=Wishlist.where(property_id: @property.id).all
        @check.each do |obj|
          @renter=Renter.find(obj.renter_id)
          @agent=Agent.find(@property.agent_id)
           UserMailer.propertyavailabe(@renter,@agent,@property).deliver_now
        end
        @unrent.destroy
        redirect_to rentedlistp_path,notice: " The property has been unrented"
      end


      
      private
    def property_params
        params.require(:@properties).permit(:name,  :agent_id,:address, :city, :rent, :bedrooms,:description, images: [])

    end
end
