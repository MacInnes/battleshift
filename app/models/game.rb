class Game < ApplicationRecord
  attr_accessor :messages, :winner

  enum current_turn: ["player_1", "player_2"]
  serialize :player_1_board
  serialize :player_2_board

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true

  belongs_to :player_1, class_name: 'User', foreign_key: 'player_1_id'
  belongs_to :player_2, class_name: 'User', foreign_key: 'player_2_id'

  validates :player_1, presence: true

  def change_turn
    if self.current_turn == "player_1"
      self.current_turn = "player_2"
    else
      self.current_turn = "player_1"
    end
  end

end
