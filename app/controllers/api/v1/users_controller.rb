module Api
  module V1
    class UsersController < ApiController

      def index
        render json: User.all
      end

      def show
        user = User.find_by_id(params[:id])
        render json: user if user
        render status: :not_found unless user
      end

      def update
        user = User.find_by_id(params[:id])
        user.update(email: params[:email])
      end

    end
  end
end
