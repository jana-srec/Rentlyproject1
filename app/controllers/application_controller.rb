class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  #allowing a set of parameter for input in devise
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :address, :contact])
  end
  

  #deciding the path after devise signin
  def after_sign_in_path_for(resource)
    if resource.class == Agent
        stored_location_for(resource) || "/displayprop"
    elsif resource.class == Renter
      stored_location_for(resource) || "/viewprop"
    end
  end

end