module Api
  module V1
    class UsersController < ApiController
      def index
        render json: User.all
      end

      def show
        user = User.find_by_id(params[:id])
        if user
          render json: user
        else
          render status: :not_found
        end
      end
    end
  end
end
