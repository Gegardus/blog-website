class Post < ApplicationRecord
  after_save :posts_count

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  def posts_count
    author.increment!(:posts_counter)
  end

  def last_comments
    comments.limit(5).order(created_at: :desc)
  end
end
