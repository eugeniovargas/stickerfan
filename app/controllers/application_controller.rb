class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def index
    
    redirect_to "https://api.instagram.com/oauth/authorize/?client_id=22ea68b72f234ef9a3bf96720923c098&redirect_uri=http://localhost:2000/user&response_type=code"

  end
  
end