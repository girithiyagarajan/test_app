class UsersController < ApplicationController
  before_action :check_for_cancel, only: [:create, :update]
  # controller checks for login sessions still pending
  
  def index
    @users = User.all.paginate(page: params[:page], per_page: 2)
  end
  
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_permit_params)
    if @user.save
      flash[:success] = "Welcome to the blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
    find_user
  end
  
  def show
    find_user
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end
  
  def update
    find_user
    if @user.update(user_permit_params)
      flash[:success] = "#{@user.username} information successfully changed"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def destroy
    find_user
    @user.destroy
    flash[:success] = "User and associated articles successfully deleted"
    redirect_to users_path
  end
  
  private
  
  def user_permit_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def find_user
    @user = User.find(params[:id])
  end
  
  def check_for_cancel
    redirect_to articles_path if params[:cancel]
  end
  

end
