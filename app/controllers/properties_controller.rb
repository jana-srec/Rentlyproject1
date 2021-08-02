class PropertiesController < ApplicationController
   
    def new
       @agent =current_agent
       @properties=Property.new
        
       
    end
    def create
        
        @properties=Property.new(property_params)
        @properties.flag=0
        @agent=current_agent
        
        @temp = Property.where(address: @properties.address).take
        
        if @temp != nil
        render 'new'
        else
        @properties.agent_id = @agent.id
        if @properties.save
            redirect_to displayprop_path
        else
                render 'new'
        end
       
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
    private
    def property_params
        params.require(:@properties).permit(:name,  :agent_id,:address, :city, :rent, :bedrooms,:description)

    end
end
