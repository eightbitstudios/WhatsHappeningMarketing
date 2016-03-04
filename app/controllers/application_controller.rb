class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_user_agent
    if request.user_agent =~ /iPhone/
      @user_agent = 'ios'
    else
      @user_agent = 'web'
    end
  end

end