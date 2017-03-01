class Admin::UsersController < Admin::ApplicationController
  def new
    
    @page_title = 'Add User'
    @user = User.new
  end

  def show
  end

  def index
    
    if params[:search]
      @users = User.search(params[:search]).all.order('created_at DESC').paginate(:per_page => 2, :page => params[:page])
    else
      @users = User.all.order('created_at DESC').paginate(:per_page => 2, :page => params[:page])
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    
    @user = User.new(user_params)
  
    if @user.save
    
        flash[:notice] = 'user Created'
    
       redirect_to admin_users_path
    
    else
    
      render 'new'
    flash[:alert] = 'wrong '
    end
 
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    
        flash[:notice] = 'user Updated'
    
       redirect_to admin_users_path
    
    else
    
      render 'new'
    flash[:alert] = 'wrong '
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'user Gone ... !!!'
    redirect_to admin_users_path
  end
  private
    def user_params
  
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  
    end
end
