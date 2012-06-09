class PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end
  
  def search
    @posts = Post.search do |s|
      s.query do |q|
        q.text :_all, params[:text]
      end
      s.highlight :title, :body
    end
  end
  
  def new
    @post = Post.new
  end
  
  def edit
    @post = Post.find params[:id]
  end

  def show
    @post = Post.find params[:id]
  end
  
  def update
    @post = Post.find params[:id]
    if @post.update_attributes(params[:post])
      redirect_to posts_path, :notice => 'post updated'
    else
      render 'edit'
    end
  end
  
  def create
    @post = Post.new params[:post]
    if @post.save
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  def destroy
    @post = Post.find params[:id]
    @post.destroy
    Post.index.refresh
    redirect_to posts_path, :notice => 'post deleted'
  end
end