class HomeController < ApplicationController

  def index
    @sponsors = Sponsor.where(visible: true, homepage: true)
    @news = News.all
  end

end
