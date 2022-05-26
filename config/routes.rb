# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  # Create an API endpoint to list all posts for a user.
  # Create an API endpoint to list all comments for a user's post.
  # Create an API endpoint to add a comment to a post. The owner of the comment is the user that makes it.
  # Add authentication to your API endpoints.
  # Your API endpoints should receive JSON and respond JSON as well.

  namespace :api , defaults: { format: :json } do
    namespace :v1 do
      post 'users/sign_up' => 'users#register'
      post 'users/sign_in' => 'users#login'
      get 'posts' => 'posts#index'
      get 'comments' => 'comments#index'
      post 'comments/create' => 'comments#create'
    end
  end

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: %i[new create]
    end
  end

  # get 'users', to: 'users#index'
  # get 'users/:user_id', to: 'users#show'
  # get 'users/:user_id/posts', to: 'posts#index'
  # get 'users/:user_id/posts/:id', to: 'posts#show'
end
