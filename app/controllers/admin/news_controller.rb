class Admin::NewsController < Admin::BaseAdminController
  before_action :news_must_exist,   except: [:index, :new, :create]

  def index
    @news = News.all
  end

  def new
    @news = News.new
  end

  def create
  end

  def news_must_exist
    @news = News.find_by(id: params[:news_id]) || News.find_by(id: params[:id])
    if !@news
      render_404
    end
  end

end
