class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def new
    @comment = @post.comments.build
    #@comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    #@comment = Comment.new(post_params)
    if @comment.save
      flash[:notice] = "Comment has been saved."
      redirect_to @post
    else
      flash[:alert] = "Comment has not been saved."
      render "new"
    end
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "Comment has been updated."
      redirect_to post_path(@post)
    else
      flash[:error] = "Comment has not been updated."
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      flash[:error] = "Failed to update post."
      redirect_to edit_post_path(@post)
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: "Comment has been deleted."
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_to posts_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :author)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])    

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :author)
  end
end
