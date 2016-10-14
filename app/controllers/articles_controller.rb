class ArticlesController < ApplicationController
  
  before_filter :check_for_cancel, only: [:create,:update]
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    @article = find_article
  end
  
  def update
    @article = find_article
    if @article.update(permit_params)
      flash[:success] = "Article successfully Updated"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end
  
  
  def create
    @article = Article.new(permit_params)
    if @article.save
      flash[:success] = "Article successfully Created"
      redirect_to article_path(@article)
    else
      render "new"
    end
  end
  
  def destroy
    @article = find_article
    @article.destroy
    redirect_to articles_path
  end
  
  def show
    @article = find_article
  end

  
  
  private
  
    def permit_params
      params.require(:article).permit(:title, :description)
    end
    
    def find_article
       @article = Article.find(params[:id])
    end
    
    def check_for_cancel
  
       redirect_to articles_path if params[:cancel]
    end
end
