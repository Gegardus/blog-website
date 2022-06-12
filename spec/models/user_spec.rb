require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Ani', photo: 'ani.png', bio: 'Teacher', posts_counter: 0) }

  before { subject.save }

  it 'checks if name present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'checks for posts counter be numeric' do
    subject.posts_counter = 'not-numeric'
    expect(subject).to_not be_valid
  end

  it 'checks for posts counter be equal or greater than zero' do
    expect(subject.posts_counter).to be >= 0
  end

  it 'loads only three last posts' do
    expect(subject.last_posts).to eq(subject.posts.last(3))
  end
end
