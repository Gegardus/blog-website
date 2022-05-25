# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:each) do
      get '/users'
    end

    it 'shows that GET requests response status was correct' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders a correct template' do
      expect(response).to render_template(:index)
    end

    it 'shows that response body includes correct placeholder text' do
      expect(response.body).to include('List of all Users')
    end

    describe 'GET #show' do
      before(:each) do
        user = User.create(name: 'Ani', photo: 'img.jpg', bio: 'Adviser', email: 'test@email',
                           password: 'password', confirmed_at: Time.now)
        get user_path(id: user.id)
      end

      it 'GET requests response status was correct' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders a correct template' do
        expect(response).to render_template(:show)
      end

      it 'renders content correctly' do
        expect(response.body).to include('User\'s info')
      end
    end
  end
end
