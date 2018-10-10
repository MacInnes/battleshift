module Api
  module V1
    class GamesController < ActionController::API
      def show
        game = Game.find_by(id: params[:id])
        render status: 400 unless game
        render json: game if game
      end
    end
  end
end
