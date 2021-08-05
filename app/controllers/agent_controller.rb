class AgentController < ApplicationController
    def login
        @agentl=Agent.new
    end
    <<-manualvalidation
    def loginvalidation
        @agentl=Agent.new(params.require(:@agentl).permit(:email, :password))
       check_email=@agentl.email
       @temporaty=(Agent.where(email:check_email)).take
        if @temporaty!= nil
            tempstring=@agentl.password
            originalpass=@temporaty.password
        if tempstring.eql?(originalpass)  
            redirect_to @temporaty
        else
            render 'login'
        end
        else
            render 'login'
        end
    end
    manualvalidation

    def new
        @agent=Agent.new()
    end
    def create
        @agent=Agent.new(agent_params)
        @agent.save
    end
    def show
    @agent = current_agent 
  	@properties = @agent.properties 
    end
    def viewapproach
        @approach=Approach.new()
        @property=Property.find(params[:id])
        @approachlist=Approach.where(properties_id:@property.id).all
        if @property.flag == 1  
        @rentedp=Rentedlist.where(property_id: @property.id).take
        end
    end
    def addapproach
        @approach=Approach.new()
        @property=Property.find(params[:id])
        @renter=current_renter
        @approach.properties_id=@property.id
        @approach.renters_id=@renter.id
        @approach.approachflag = 1
        if @approach.save
        redirect_to viewproperty_path(@property)
        else
        redirect_to viewproperty_path(@property), notice: "Unable to add approaches soryy!!try after some months"
        end
    end
   
    private 
  def agent_params 
    params.require(:@agent).permit(:email, :password, :contact, :address, :name)
  end 
    
end
