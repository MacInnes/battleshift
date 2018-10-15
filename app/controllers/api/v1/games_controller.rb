module Api
  module V1
    class GamesController < ActionController::API
      def show
        game = Game.find_by_id(params[:id])
        render status: 400 unless game
        render json: game if game
      end

      def create
        game = Game.new(
          player_1_board: Board.new(4),
          player_2_board: Board.new(4),
          player_1_turns: 0,
          player_2_turns: 0,
          current_turn: "challenger"
        )
        game.save
        render json: game
      end
    end
  end
end
