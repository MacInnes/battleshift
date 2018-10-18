class TurnProcessor
  attr_reader :status

  def initialize(game, target)
    @game   = game
    @target = target
    @messages = []
    @status = 200
  end

  # def validate_turn
  #   if @game.current_turn == "player_1" && @game.player_1_id == @user.id
  #     @game.change_turn
  #     run!
  #   elsif @game.current_turn == "player_2" && @game.player_2_id == @user.id
  #     @game.change_turn
  #     run!
  #   end
  # end

  def run!
    begin
      # attack_opponent
      # game.save!

      # if opponent.board.all_sunk?
      #   #TODO: refactor battleship sunk to this class
      #   @messages << "Game over."
      #   @game.winner(@user)
      #   @game.save!
      # end
      if @game.current_turn == 'player_1' && @game.player_2.nil?
        attack_opponent(@game.player_2_board, @game.player_1)
        ai_attack_back
        @game.save
      elsif @game.current_turn == 'player_1'
        attack_opponent(@game.player_2_board, @game.player_1)
        @game.change_turn
        @game.save
      elsif @game.current_turn == 'player_2'
        attack_opponent(@game.player_1_board, @game.player_2)
        @game.change_turn
        @game.save
      end
    rescue InvalidAttack => e
      @status = 400
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target

  def attack_opponent(player_board, player)
    result = Shooter.new(board: player_board, target: target).fire!
    @messages << "Your shot resulted in a #{result}"
    if win?(player_board)
      @messages << 'Game over.'
      @game.winner = player.email
      @game.save
    end
  end

  def ai_attack_back
    result = AiSpaceSelector.new(@game.player_1_board).fire!
    @messages << "The computer's shot resulted in a #{result}."
    if win?(@game.player_1_board)
      @messages << ' Game over.'
      @game.winner = 'Computer'
      @game.save
    end
  end

  def win?(player_board)
    player_board.all_sunk?
  end

end
