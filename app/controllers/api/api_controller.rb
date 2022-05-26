module Api
  class ApiController < ActionController::Base
    protect_from_forgery with: :null_session

    SECRET = 'secret'.freeze # Put your secret here

    def authentication
      decode_data = decode_user_data(request.headers['token'])

      render json: { result: 'Failure', errors: ['Invalid token'] }, status: :forbidden and return unless decode_data

      user_data = decode_data[0]['user_data'] if decode_data
      @current_user = User.find(user_data)
    end

    def encode_user_data(payload)
      JWT.encode payload, SECRET, 'HS256'
    end

    def decode_user_data(token)
      JWT.decode token, SECRET, true, { algorithm: 'HS256' }
    end
  end
end
