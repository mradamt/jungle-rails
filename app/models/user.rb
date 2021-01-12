class User < ActiveRecord::Base
  
  has_secure_password
  
  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email)
    # If the user exists AND the password entered is correct return @user else return nil
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
  
end
