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

   
    private 
  def agent_params 
    params.require(:@agent).permit(:email, :password, :contact, :address, :name)
  end 
    
end
