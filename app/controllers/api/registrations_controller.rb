module Api
  class RegistrationsController < ApiController
    include Dry::Monads[:result]

    def create
      res = Register.new.call(user_params)

      case res
      in Success(User)
        val = res.value!
        token = encode_user_data({ user_data: val.id })

        render json: { result: 'Success', token: }

      in Failure(:user_exists)
        errors = prepare_errors('You are already registered in MD PDP.')

        render json: { result: 'Failure', errors: [errors] }, status: :unprocessable_entity

      in Failure(:not_found)
        errors = prepare_errors('User with this email and password is not found in MD People.')

        render json: { result: 'Failure', errors: [errors] }, status: :unprocessable_entity

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
