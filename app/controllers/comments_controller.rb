class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @new_comment = current_user.comments.new(comment_params)
    @new_comment.post_id = params[:post_id]

    if @new_comment.save
      redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", flash: { alert: 'Your comment saved' }
    else
      flash.now[:error] = 'Could not save comment'
      @article = Post.find(params[:post_id])
      redirect_to post_path(@post)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @post.decrement!(:comments_counter)
    @comment.destroy!
    redirect_to user_post_path(id: @post.id), notice: 'Comment was successfully deleted!'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
