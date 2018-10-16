module Api
  module V1
    class GamesController < ActionController::API
      def show
        game = Game.find_by_id(params[:id])
        render status: 400 unless game
        render json: game if game
      end

      def create
        player1 = User.find_by_api_key(request.headers['X-API-KEY'])
        player2 = User.find_by_email(params['opponent_email'])
        game = Game.new(
          player_1_board: Board.new(4),
          player_2_board: Board.new(4),
          player_1_turns: 0,
          player_2_turns: 0,
          current_turn: "challenger",
          player_1: player1,
          player_2: player2
        )
        game.save
        render json: game
      end
    end
  end
end
