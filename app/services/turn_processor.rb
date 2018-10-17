class TurnProcessor
  attr_reader :status

  def initialize(game, target, user)
    @game   = game
    @target = target
    @messages = []
    @user = user
    @status = 200
  end

  def validate_turn
    if @game[:winner]
      @status = 400
      @messages << "Invalid move. Game over."
    elsif @game.current_turn == "player_1" && @game.player_1_id == @user.id
      @game.change_turn
      run!
    elsif @game.current_turn == "player_2" && @game.player_2_id == @user.id
      @game.change_turn
      run!
    else
      @status = 400
      @messages << "Invalid move. It's your opponent's turn"
    end
  end

  def run!
    begin
      attack_opponent
      game.save!

      if opponent.board.all_sunk?
        #TODO: refactor battleship sunk to this class
        @messages << "Game over."
        @game.winner = @user.email
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

  attr_reader :game, :target, :user

  def attack_opponent
    result = Shooter.fire!(board: opponent.board, target: target)
    @messages << "Your shot resulted in a #{result}"
    game.player_1_turns += 1
  end

  def ai_attack_back
    result = AiSpaceSelector.new(player.board).fire!
    @messages << "The computer's shot resulted in a #{result}"
    game.player_2_turns += 1
  end

  def opponent
    if game.player_1_id == user.id
      Player.new(game.player_2_board)
    elsif game.player_2_id == user.id
      Player.new(game.player_1_board)
    end
  end

  def win?
    opponent.board.all_sunk?
  end

end
