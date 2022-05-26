
module Api
    class UsersController < ApiController
      before_action :authentication
  
      def show
        user = user_params[:id].nil? ? current_user : User.find(user_params[:id])
        authorize(user)
  
        user = UserBlueprint.render(user)
  
        render json: user
      end
  
      private
  
      def user_params
        params.permit(:id)
      end
    end
  end
  