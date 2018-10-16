class Api::V1::Games::ShipsController < ApiController
  def create
    game   = Game.find_by_id(params[:game_id])
    player = User.find_by_api_key(request.headers['X-API-KEY'])
    ship   = Ship.new(params['ship_size'])

    placer = ShipPlacer.new(
      board: board_finder(player, game),
      ship: ship,
      start_space: params['start_space'],
      end_space: params['end_space']
    )
    placer.run
    game.save

    render json: game, message: placer.message(ship.length)
  end

  private

  def board_finder(player, game)
    if player.api_key == ENV['BATTLESHIFT_API_KEY']
      game.player_1_board
    else
      game.player_2_board
    end
  end
end