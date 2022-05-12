class Like < ApplicationRecord
  after_save :likes_count

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  def likes_count
    post.increment!(:likes_counter)
  end
end
