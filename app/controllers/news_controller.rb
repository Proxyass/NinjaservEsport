class NewsController < ApplicationController
  before_action :news_must_exist,   only: [:show]

  def index
    @news = News.all
  end

  def show
  end

  def news_must_exist
    @news = News.find_by(id: params[:news_id]) || News.find_by(id: params[:id]) || News.find_by(beauty_url: params[:slug])
    if !@news
      render_404
    end
  end
end
