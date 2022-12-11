class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_admin!, if: :admin_url 

  def admin_url
    request.fullpath.include?("/admin")
  end
  


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  def ensure_guest_customer
    if customer_signed_in? && current_customer.email == 'guest@example.com'
      redirect_to customers_my_page_path
    end
  end
  
end
