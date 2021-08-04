class UserMailer < ApplicationMailer
  #sending mail   
  default :from => "onlineeventparticipation@gmail.com"
  #for Agent
    def propertyrented(renter,agent,property)
        @renter = renter
        @agent= agent
        @property = property
       
        mail(:to => @agent.email, :subject => "Approachment of your property")
      end

  #for Renters
      def propertyavailabe(renter, agent, property)
        @renter=renter
        @agent=agent
        @property=property
        puts "#{@renter.name}"
        mail(:to => @renter.email, :subject => "Property is availabe")
      end
end
