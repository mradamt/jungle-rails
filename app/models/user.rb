class User < ActiveRecord::Base
  
  has_secure_password

  # Clean user email of whitespace and convert to lowercase
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

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  
end
