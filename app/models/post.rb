class Post < ApplicationRecord
  after_save :posts_count

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { in: 1..250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  def last_comments
    comments.limit(5).order(created_at: :desc)
  end

  private

  def posts_count
    author.increment!(:posts_counter)
  end
end
