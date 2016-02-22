class HappeningsController < ApplicationController

  def show
    @happening_key = params[:happening_key]
  end

end