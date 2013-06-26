class Admin::PostsController < ApplicationController
 http_basic_authenticate_with name: "geek", password: "jock", except: [:new, :create, :show]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])   
    puts "------------------------------------"
    p Post.count
    if @post.save
      flash[:notice] = "Post was successfully saved."
      p Post.count
      redirect_to admin_post_url(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to admin_post_url(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:destroy])
    post.destroy

    redirect_to admin_posts_url
  end
end
