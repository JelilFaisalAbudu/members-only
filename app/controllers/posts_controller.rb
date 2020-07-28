class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = 'Post was successfully created'
      redirect_to root_path
    else
      render 'new'
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
    if @post.update(post_params)
      flash[:notice] = "post was successfully updated"
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
