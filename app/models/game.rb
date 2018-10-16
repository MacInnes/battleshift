class Game < ApplicationRecord
  attr_accessor :messages

  enum current_turn: ["challenger", "computer"]
  serialize :player_1_board
  serialize :player_2_board

  validates :player_1_board, presence: true
  validates :player_2_board, presence: true

  belongs_to :player_1, class_name: 'User', foreign_key: 'player_1_id'
  belongs_to :player_2, class_name: 'User', foreign_key: 'player_2_id'

  validates :player_1, presence: true
end
