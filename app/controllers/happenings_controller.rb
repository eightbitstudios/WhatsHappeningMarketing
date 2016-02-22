class HappeningsController < ApplicationController

  def show
    @key = params[:happening_key]
  end

end