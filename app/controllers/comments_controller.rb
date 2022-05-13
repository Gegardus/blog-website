class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @new_comment = current_user.comments.new(comment_params)
    @new_comment.post_id = params[:post_id]

    if @new_comment.save
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", notice: 'Success!'
    else
      @article = Post.find(params[:post_id])
      redirect_to post_path(@post)
    end
  end

  # def create
  #   @comment = Comment.new(comment_params)
  #   @post = Post.find(params[:post_id])
  #   @comment.author_id = current_user.id
  #   @comment.post_id = @post.id

  #   if @comment.save
  #     redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
  #   else
  #     render :new, alert: 'An error has occurred while creating the comment'
  #   end
  # end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
