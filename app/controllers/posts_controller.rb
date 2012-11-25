class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index,:show]
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      params[:post][:category_names].split(/,/).each do |catname|
        @post.categories << Category.find_or_create_by_name(catname)
      end
      redirect_to @post, :notice => "Successfully created post."
    else
      render :action => 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      @post.categories.delete_all
      params[:post][:category_names].split(/,/).each do |catname|
        @post.categories << Category.find_or_create_by_name(catname)
      end
      redirect_to @post, :notice  => "Successfully updated post."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, :notice => "Successfully destroyed post."
  end
end
