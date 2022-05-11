class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  # def posts_count
  #   author.increment!(:posts_counter) 
  # end

  def user_post_counter
    counter = Post.where(author_id:).count
    author = User.find_by(id: author_id)
    author.update(posts_counter: counter)
  end

  def last_comments
    comments.limit(5).order(created_at: :desc)
  end
end

