class Admin::NewsController < Admin::BaseAdminController
  before_action :news_must_exist,   except: [:index, :new, :create]

  def index
    @news = News.all
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)
    @news.user = current_logged_user
    if @news.save
      flash[:success] = "News "+@news.title.capitalize+" successfully created."
      redirect_to new_admin_news_path
    else
      flash.now[:danger] =  "Failed to create "+@news.title + ", "+@news.errors.full_messages.to_sentence+"."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @news.update(news_params)
      flash[:success] = "News "+@news.title.capitalize+" successfully updated."
      redirect_to admin_news_index_path
    else
      flash[:danger] =  "Failed to update "+@news.title + ", "+@news.errors.full_messages.to_sentence+"."
      redirect_to edit_admin_news_path(@news.id)
    end
  end

  def delete
  end

  def destroy
    if @news.destroy
      flash[:success] = "Team "+@news.title.capitalize+" successfully deleted."
      redirect_to news_path
    else
      flash.now[:danger] =  "Failed to delete "+@news.title + ", "+@news.errors.full_messages.to_sentence+"."
      render 'delete'
    end
  end

  def news_must_exist
    @news = News.find_by(id: params[:news_id]) || News.find_by(id: params[:id])
    if !@news
      render_404
    end
  end

  def news_params
    params.require(:news).permit(:title, :caption, :beauty_url, :content, :visible)
  end

end
