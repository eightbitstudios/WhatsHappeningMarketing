class HappeningsController < ApplicationController

  require 'open-uri'

  def show
    key = params[:happening_key]
    @happenings = get_happenings key
  end

  private

    def get_happenings key
      url = "https://whatshappening.eightbitstudios.com/api/v1/web_app/feeds/#{key}"
      JSON.parse open(url).read
    end

end