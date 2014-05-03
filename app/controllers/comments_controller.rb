class CommentsController < ApplicationController
  #before_action :find_post, except: [:index, :new, :create
#                                    ]
  def post
    #@posts = Post.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(post_params)
    if @comment.save
      redirect_to post_path(@post)
    else
      flash[:error] = "Failed to create post."
      redirect_to new_post_path
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      flash[:error] = "Failed to update post."
      redirect_to edit_post_path(@post)
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :author)
  end
end
