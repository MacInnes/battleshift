module Api
  module V1
    module Games
      class ShotsController < ApiController
        before_action :validate_api_keys, :find_game, :find_player, :verify_game_status, :verify_turn

        def create
          turn_processor.run!
          
          render json: game, status: turn_processor.status, message: turn_processor.message
        end

        private

        attr_reader :game, :user

        def find_game
          @game ||= Game.find(params[:game_id])
        end

        def find_player
          @user ||= User.find_by_api_key(request.headers['X-API-KEY'])
        end

        def turn_processor
          @turn_processor ||= TurnProcessor.new(game, params[:shot][:target])
        end

        def current_player?
          game.player_1 == user && game.current_turn == 'player_1' || game.player_2 == user && game.current_turn == 'player_2'
        end

        def verify_turn
          render json: game, status: 400, message: "Invalid move. It's your opponent's turn" unless current_player?
        end

        def verify_game_status
          render json: game, status: 400, message: 'Invalid move. Game over.' unless game[:winner].nil?
        end
      end
    end
  end
end
