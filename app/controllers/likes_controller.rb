class LikesController < ApplicationController
  def new
    @like = Like.new
  end 

  def create
    @post = Post.find(params[:post_id])
    @new_like = current_user.likes.new(author_id: current_user.id, post_id: @post.id)

    respond_to do |format|
      if @new_like.save
        format.html { redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", notice: 'Success!' }
      else
        format.html { redirect_to "/users/#{@post.author_id}/posts/#{@post.id}", alert: 'Error occured!' }
      end
    end
  end

  # def create
  #   @post = Post.find(params[:post_id])
  #   @user = current_user
  #   @like = Like.new(author_id: @user.id, post_id: @post.id)

  #   if @like.save
  #     @post = Post.find(params[:post_id])
  #     redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
  #   else
  #     redirect_to user_post_path(user_id: @post.author_id, id: @post.id),
  #                 alert: 'An error has occurred while creating the like'
  #   end
  # end
end
