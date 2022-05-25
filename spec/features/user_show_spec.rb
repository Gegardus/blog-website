require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Ani', photo: 'img.jpg', bio: 'Adviser', email: 'test@email.com',
                        password: 'password', confirmed_at: Time.now)
    @post = Post.create(author: @user, title: 'My title', text: 'My text')
    (1..5).each { |i| @user.posts.create title: "Post number #{i}", text: "This is my #{i} post!" }
    @like = Like.create(author: @user, post_id: @post.id)
    visit new_user_session_path
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit user_path @user.id
  end

  it 'shows the users profile picture' do
    expect(page.find('img')['src']).to have_content 'img.jpg'
  end

  it 'shows the username' do
    expect(page).to have_content 'Ani'
  end

  it 'shows the number of users posts' do
    expect(page).to have_content 'posts: 6'
  end

  it 'shows the users bio' do
    expect(page).to have_content 'Adviser'
  end

  it 'can see the users first 3 posts' do
    expect(page).to have_content 'Post number 5'
    expect(page).to have_content 'Post number 4'
    expect(page).to have_content 'Post number 3'
    expect(page).to have_no_content 'Post number 2'
  end

  it 'shows a button that leads to view of a user all posts.' do
    expect(page.find('a', text: 'All posts')).to have_content 'All posts'
  end

  it "redirects me to that post's show page when clicked" do
    click_on 'Post number 5'
    expect(current_path).to eq user_post_path user_id: Post.last.author.id, id: Post.last.id
  end

  it "it redirects me to the user's post's index page when clicked" do
    click_on 'All posts'
    expect(current_path).to eq user_posts_path user_id: User.last.id
  end
end
