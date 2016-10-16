class ArticlesController < ApplicationController
  
  before_filter :check_for_cancel, only: [:create,:update]
  
  def index
    @articles = Article.all.paginate(page: params[:page], per_page: 2)
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    find_article
  end
  
  def update
    find_article
    if @article.update(article_permit_params)
      flash[:success] = "Article successfully Updated"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end
  
  
  def create
    @article = Article.new(article_permit_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article successfully Created"
      redirect_to article_path(@article)
    else
      render "new"
    end
  end
  
  def destroy
    find_article
    @article.destroy
    redirect_to articles_path
  end
  
  def show
    @article = find_article
  end

  
  
  private
  
    def article_permit_params
      params.require(:article).permit(:title, :description)
    end
    
    def find_article
       @article = Article.find(params[:id])
    end
    
    def check_for_cancel
       redirect_to articles_path if params[:cancel]
    end
end
