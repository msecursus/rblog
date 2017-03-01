class PostsController < ApplicationController
   before_action :set_post, only: [:show]
  def new
    
    @page_title = 'Add Post'
    @post = Post.new
  end

  def show
  end

  def index 
    if params[:search]
      @posts = Post.search(params[:search]).all.order('created_at DESC').paginate(:per_page => 2, :page => params[:page])
    else
      @posts = Post.all.order('created_at DESC').paginate(:per_page => 2, :page => params[:page])
    end
    
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    
    @post = Post.new(post_params)
  
    if @post.save
    
        flash[:notice] = 'Post Created'
    
       redirect_to admin_posts_path
    
    else
    
      render 'new'
    flash[:alert] = 'wrong '
    end
 
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
    
        flash[:notice] = 'Post Updated'
    
       redirect_to admin_posts_path
    
    else
    
      render 'new'
    
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post Gone ... !!!'
    redirect_to admin_posts_path
  end
  def set_post
      @post = Post.find(params[:id])
    end
  private
    def post_params
  
      params.require(:post).permit(:title, :category_id, :user_id, :tags, :body, :image)
  
    end
end
