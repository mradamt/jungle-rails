class UsersController < ApplicationController
  def new
    # @user = User.new
  end

  def create
    @user = User.new(user_params)
    # Clean email (strip whitespace and make lowercase) before entering
    @user[:email] = User.clean_email(@user[:email])
    # If the new entry saves without errors, begin a new session and redirect to root
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
