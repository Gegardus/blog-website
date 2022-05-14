class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @new_like = current_user.likes.new(author_id: current_user.id, post_id: @post.id)

    respond_to do
      if @new_like.save
        redirect_to "/users/#{@post.author_id}/posts/#{@post.id}"
        flash[:notice] = 'Your like was added'
      else
        redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", alert: 'An error occurred adding like'
      end
    end
  end
end
