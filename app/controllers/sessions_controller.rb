class SessionsController < ApplicationController
  def new
  end

  def create
    
    if user = User.authenticate_with_credentials(session_params[:email], session_params[:password])
      # Save the user id inside the browser cookie to keep the user logged in as they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
  
end
