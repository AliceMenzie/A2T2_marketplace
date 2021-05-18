class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

  private
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, addresses_attributes: [:state, :postcode, :street, :number]])
  end
end

# address_attributes: [:state, :postcode, :street, :number]