class MarketingController < ApplicationController

  before_filter :set_user_agent, only: [:app]

  def index
  end

  def app
    case @user_agent
      when 'web'
        redirect_to "/"
      when 'ios'
        redirect_to "happenings://"
      end
  end

end