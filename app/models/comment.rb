class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post 

#   def comments_count
#     post.increment!(:comments_counter)
#   end

def update_comments_counter
  counter = Comment.where(post_id:).count
  post = Post.find_by(id: post_id)
  post.update(comments_counter: counter)
end
end
