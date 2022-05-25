require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
    before(:each) do
      @user = User.create(name: 'Hammas', photo: 'img.jpg', bio: 'Developer', email: 'test@email.com',
                          password: 'password', confirmed_at: Time.now)
      @post = Post.create(author: @user, title: 'My title', text: 'My text')
      @like = Like.create(author: @user, post_id: @post.id)
      visit new_user_session_path
      fill_in 'Email', with: 'test@email.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
    end
    it 'shows the username' do
      expect(page).to have_content 'Hammas'
    end
    it 'shows the number of posts of the the user' do
      expect(page).to have_content 'posts: 1'
    end
  end
  