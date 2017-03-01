class Admin::CategoriesController < Admin::ApplicationController
  def new
    
    @page_title = 'Add Category'
    @category = Category.new
  end

  def show
  end

  def index
    
    if params[:search]
      @categories = Category.search(params[:search]).all.order('created_at DESC').paginate(:per_page => 2, :page => params[:page])
    else
      @categories = Category.all.order('created_at DESC').paginate(:per_page => 2, :page => params[:page])
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    
    @category = Category.new(category_params)
  
    if @category.save
    
        flash[:notice] = 'category Created'
    
       redirect_to admin_categories_path
    
    else
    
      render 'new'
    flash[:alert] = 'wrong '
    end
 
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
    
        flash[:notice] = 'category Updated'
    
       redirect_to admin_categories_path
    
    else
    
      render 'new'
    flash[:alert] = 'wrong '
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = 'category Gone ... !!!'
    redirect_to admin_categories_path
  end
  private
    def category_params
  
      params.require(:category).permit(:name)
  
    end
end
