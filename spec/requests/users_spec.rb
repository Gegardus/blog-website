require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:each) do
      get '/users'
    end

    it 'GET requests response status 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders a template' do
      expect(response).to render_template(:index)
    end

    it 'response body contains correct placeholder text' do
      expect(response.body).to include('List of all Users')
    end

    describe 'GET #show' do
      before(:each) do
        get '/users/1'
      end

      it 'GET requests response status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders a template' do
        expect(response).to render_template(:show)
      end

      it 'renders content correctly' do
        expect(response.body).to include('User\'s info')
      end
    end
  end
end
