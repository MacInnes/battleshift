module Api
  module V1
    class GamesController < ActionController::API
      before_action :set_game, only: :show
      before_action :set_players, :new_game, only: :create

      def show
        render status: 400 unless game
        render json: game if game
      end

      def create
        game.save
        render json: game
      end

      private

      attr_reader :game, :player1, :player2

      def set_game
        @game ||= Game.find_by_id(params[:id])
      end

      def set_players
        @player1 = User.find_by_api_key(request.headers['X-API-KEY'])
        @player2 = User.find_by_email(params['opponent_email'])
      end

      def new_game
        @game ||= Game.new(game_creation_params)
      end

      def game_creation_params
        {
          player_1_board: Board.new(4),
          player_2_board: Board.new(4),
          current_turn: 'player_1',
          player_1_id: player1.id,
          player_2_id: player2.id
        }
      end
    end
  end
end
