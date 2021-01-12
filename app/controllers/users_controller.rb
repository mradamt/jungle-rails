class UsersController < ApplicationController
  def new
    # @user = User.new
  end

  def create
    @user = User.new(user_params)
    # Convert email to lowercase
    @user[:email] = User.clean_email(@user[:email])
    if @user.save
      session[:user_id] = @user.id
      redirect_to :root
    else
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
