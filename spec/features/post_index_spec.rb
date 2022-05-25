# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Ani', photo: 'img.jpg', bio: 'Developer', email: 'test@email.com',
                        password: 'password', confirmed_at: Time.now)
    (1..5).each { |i| @user.posts.create title: "Post number #{i}", text: "This is my #{i} post!" }
    @post = Post.create(author: @user, title: 'My title', text: 'My text')
    @comment = Comment.create(text: 'My first comment', author: @user, post_id: @post.id)
    @like = Like.create(author: @user, post_id: @post.id)
    visit new_user_session_path
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit user_posts_path @user.id
  end

  it 'shows the users profile picture' do
    expect(page.find('img')['src']).to have_content 'img.jpg'
  end

  it 'shows the username' do
    expect(page).to have_content 'Ani'
  end

  it 'shows the number of posts of the user' do
    expect(page).to have_content 'posts: 6'
  end

  it 'shows a post title' do
    expect(page).to have_content 'My title'
  end

  it 'shows content of the post' do
    expect(page).to have_content 'My text'
  end

  it 'shows content of the comment' do
    expect(page).to have_content 'My first comment'
  end

  it 'shows number of the comments of a post' do
    expect(page).to have_content 'Comments: 1'
  end

  it 'shows number of the likes of a post' do
    expect(page).to have_content 'Likes: 1'
  end

  it 'redirects me to that posts show page when post clicked' do
    click_link(@post.id)
    expect(current_path).to eq user_post_path(user_id: @post.author_id, id: @post.id)
  end
end
