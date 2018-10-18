class Api::V1::Games::ShipsController < ApiController
  before_action :validate_api_keys, :set_game, :set_player

  def create
    ship_placer.run
    game.save

    render json: game, message: ship_placer.message(ship_params[:ship_size])
  end

  private

  attr_reader :game, :player

  def ship_params
    params.permit(:ship_size, :start_space, :end_space, :game_id)
  end

  def set_game
    @game ||= Game.find_by_id(params[:game_id])
  end

  def set_player
    @player ||= User.find_by_api_key(request.headers['X-API-KEY'])
  end

  def ship_placer_params
    {
      board: board_finder(player, game),
      ship: Ship.new(ship_params[:ship_size]),
      start_space: ship_params[:start_space],
      end_space: ship_params[:end_space]
    }
  end

  def ship_placer
    @ship_placer ||= ShipPlacer.new(ship_placer_params)
  end

  def board_finder(player, game)
    if game.player_1.api_key == request.headers['X-API-KEY']
      game.player_1_board
    elsif game.player_2.api_key == request.headers['X-API-KEY']
      game.player_2_board
    end
  end
end