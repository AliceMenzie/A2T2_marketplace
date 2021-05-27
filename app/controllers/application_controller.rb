class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:username, { addresses_attributes: %i[state postcode street number suburb] }])

    devise_parameter_sanitizer.permit(:account_update, keys: [:username, { addresses_attributes: %i[state postcode street number suburb] }])
  end
end

