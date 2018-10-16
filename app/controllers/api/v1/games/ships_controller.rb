class Api::V1::Games::ShipsController < ApiController
  def create
    @game   = Game.find_by_id(params[:game_id])
    @player = User.find_by_api_key(request.headers['X-API-KEY'])

    ship_placer.run
    @game.save

    render json: @game, message: ship_placer.message(ship_params[:ship_size])
  end

  private

  def ship_params
    params.permit(:ship_size, :start_space, :end_space, :game_id)
  end

  def ship_placer_params
    {
      board: board_finder(@player, @game),
      ship: Ship.new(ship_params[:ship_size]),
      start_space: ship_params[:start_space],
      end_space: ship_params[:end_space]
    }
  end

  def ship_placer
    @ship_placer ||= ShipPlacer.new(ship_placer_params)
  end

  def board_finder(player, game)
    if @player.api_key == ENV['BATTLESHIFT_API_KEY']
      @game.player_1_board
    else
      @game.player_2_board
    end
  end
end