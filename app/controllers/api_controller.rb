class ApiController < ActionController::API
  private

  def validate_api_keys
    game = Game.find_by_id(params[:game_id])
    if game.player_2
      if game.player_1.api_key != request.headers['X-API-KEY'] && game.player_2.api_key != request.headers['X-API-KEY']
        render json: game, status: 401, message: 'Unauthorized'
      end
    else
      if game.player_1.api_key != request.headers['X-API-KEY']
        render json: game, status: 401, message: 'Unauthorized'
      end
    end
  end
end
