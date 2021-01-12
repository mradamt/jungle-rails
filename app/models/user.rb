class User < ActiveRecord::Base
  
  has_secure_password

  def self.clean_email(email)
    email.strip.downcase
  end
  
  # If the user exists AND the password entered is correct return @user else return nil
  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(User.clean_email(email))
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
  
end
