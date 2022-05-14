require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.new(name: 'Tom', photo: 'Tom.png', bio: 'bio', posts_counter: 0)
  user.save!
  post = Post.new(title: 'New post', text: 'Good evening', author: user, likes_counter: 0, comments_counter: 0)
  post.save!

  comment_creator = User.new(name: 'Ani', photo: 'img.png', bio: 'bio', posts_counter: 0)
  comment_creator.save!
  post.comments.create!(text: 'Hello World', author: comment_creator)
  post.comments.create!(text: 'This is my second post', author: comment_creator)

  it 'adds comments' do
  expect(post.comments.length).to eql(2)
  end
end
