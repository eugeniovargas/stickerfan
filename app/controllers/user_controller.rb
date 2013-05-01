class UserController < ActionController::Base
  protect_from_forgery with: :exception
  
  def index   
  end
  
  def connect     
  end
  
  
  def instagram_auth
    redirect_to "https://api.instagram.com/oauth/authorize/?client_id=22ea68b72f234ef9a3bf96720923c098&redirect_uri=http://localhost:2000/user/instagram/photos&response_type=code"
  end
  
  def instagram_api          
    info = { :body => {client_id: "22ea68b72f234ef9a3bf96720923c098",
                      client_secret: "d8b170e6f84c4caf9ba83130d134ff6a",
                      grant_type: "authorization_code",
                      redirect_uri: "http://localhost:2000/user/instagram/photos",
                      code: params[:code] }
                    }
                
    @response = HTTParty.post("https://api.instagram.com/oauth/access_token", info)
      
    @result = HTTParty.get("https://api.instagram.com/v1/users/#{@response["user"]["id"]}/media/recent/?access_token=#{@response["access_token"]}&count=-1")

    @profile = @response["user"]["profile_picture"]
    
    @images = []
    
    @result["data"].each do |p|
      @images << p["images"]["thumbnail"]["url"]
    end

  end
  
  def photos  
    instagram_api
    
    @profile
    @images
  end
end