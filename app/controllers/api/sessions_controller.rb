module Api
  class SessionsController < ApiController
    include Dry::Monads[:result]

    def create
      res = LogIn.new.call(user_params)

      case res
      in Success(User)
        val = res.value!
        token = encode_user_data({ user_data: val.id })

        render json: { result: 'Success', token: }

      in Failure(:user_not_found)
        errors = prepare_errors('Incorrect email or password')

        render json: { result: 'Failure', errors: [errors] }, status: :forbidden

      else
        errors = prepare_errors(res)

        render json: { result: 'Failure', errors: }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:email, :password)
    end
  end
end
