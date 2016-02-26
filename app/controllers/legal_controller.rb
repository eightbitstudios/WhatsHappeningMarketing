class LegalController < ApplicationController

  require 'open-uri'

  def terms
    @content = terms_html
    render :legal
  end

  def privacy
    @content = privacy_html
    render :legal
  end

  private

    def terms_html
      open('https://whatshappening.eightbitstudios.com/api/legal/terms').read
    end

    def privacy_html
      open('https://whatshappening.eightbitstudios.com/api/legal/privacy').read
    end

end