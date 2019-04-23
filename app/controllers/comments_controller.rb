class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:create, :destroy]
  before_action :find_comment, only: [:destroy]
  before_action :authorize!, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post)
    else
      @comments = Comment.all.order(created_at: :desc)
      render 'posts/show'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  private
  def comment_params
    params.require(:comment).permit(:name, :body)
  end
  
  def find_post
    @post = Post.find(params[:post_id])
  end
  
  def find_comment
    @comment = Comment.find(params[:id])    
  end

  def authorize!
    unless can?(:crud, @comment)
      flash[:danger] = "Acess Denied. Unauthorized Action!"
      redirect_to post_path(@post)
    end
  end

end
