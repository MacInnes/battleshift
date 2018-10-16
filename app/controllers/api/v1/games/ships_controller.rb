class Api::V1::Games::ShipsController < ApiController
  def create
    game = Game.find_by_id(params[:game_id])
    player = User.find_by_api_key(request.headers['X-API-KEY'])

    ship = Ship.new(params['ship_size'])
    placer = ShipPlacer.new(
      board: game.player_1_board,
      ship: ship,
      start_space: params['start_space'],
      end_space: params['end_space']
    )

    placer.run

    require 'pry'; binding.pry

    render json: game, message: 'nonsense'
  end
end