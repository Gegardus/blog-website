require 'rails_helper'

RSpec.describe Post, type: :model do
  @user = User.create(name: 'Ani', bio: 'My life')

  subject { Post.new(author: @user, title: 'My title', text: 'My text', author_id: @user) }

  before { subject.save }

  it 'checks if title is present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'checks if title is no longer than 250 chars' do
    subject.title = 'Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world
    Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello
    world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world Hello world'
    expect(subject).to_not be_valid
  end

  it 'checks for comments counter be numeric' do
    subject.comments_counter = 'not-numeric'
    expect(subject).to_not be_valid
  end

  it 'checks for likes counter be numeric' do
    subject.likes_counter = 'not-numeric'
    expect(subject).to_not be_valid
  end

  it 'checks for likes counter be equal or greater than zero' do
    expect(subject.likes_counter).to be >= 0
  end

  it 'checks for comments counter be equal or greater than zero' do
    expect(subject.comments_counter).to be >= 0
  end

  it 'loads only five last comments' do
    expect(subject.last_comments).to eq(subject.comments.last(5))
  end
end
