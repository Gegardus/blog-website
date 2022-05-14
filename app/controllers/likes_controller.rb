class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @new_like = current_user.likes.new(author_id: current_user.id, post_id: @post.id)

    respond_to do |format|
      if @new_like.save
        format.html { redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", flash: { alert: 'Your like saved' } }
      else
        format.html { redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", flash: {alert: 'Could not save like' } }
      end
    end
  end
end
