class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @new_post = current_user.posts.new(post_params)

    respond_to do |format|
      if @new_post.save
        format.html { redirect_to "/users/#{@new_post.author.id}/posts/", flash: { alert: 'Your post saved' } }
      else
        format.html { redirect_to "/users/#{@new_post.author.id}/posts/new", flash: { alert: 'Could not save post' } }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
