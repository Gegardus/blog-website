class Comment < ApplicationRecord
  after_save :comments_count

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  private

  def comments_count
    post.increment!(:comments_counter)
  end
end
