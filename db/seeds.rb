player_1_board = Board.new(4)
player_2_board = Board.new(4)

sm_ship = Ship.new(2)
md_ship = Ship.new(3)

# Place Player 1 ships
ShipPlacer.new(board: player_1_board,
               ship: sm_ship,
               start_space: "A1",
               end_space: "A2").run

ShipPlacer.new(board: player_1_board,
               ship: md_ship,
               start_space: "B1",
               end_space: "D1").run

# Place Player 2 ships
ShipPlacer.new(board: player_2_board,
               ship: sm_ship.dup,
               start_space: "A1",
               end_space: "A2").run

ShipPlacer.new(board: player_2_board,
               ship: md_ship.dup,
               start_space: "B1",
               end_space: "D1").run

User.create!(name: "Josiah Bartlet", email: "jbartlet@example.com", address: "1600 Pennsylvania Ave NW, Washington, DC 20500", password: 'pass', password_confirmation: 'pass')
p1 = User.create!(name: 'Player1', email: 'player1@example.com', api_key: 'iM-aGiK_K9RLUubmG4-GuA', status: 'active', password: 'example', password_confirmation: 'example')
p2 = User.create!(name: 'Player2', email: 'player2@example.com', api_key: 'GW81AmeIq6Bwvf6s9AUTLg', status: 'active', password: 'example', password_confirmation: 'example')

game_attributes = {
  player_1_board: player_1_board,
  player_2_board: player_2_board,
  player_1_turns: 0,
  player_2_turns: 0,
  current_turn: "player_1",
  player_1_id: p1.id,
  player_2_id: p2.id
}

game = Game.new(game_attributes)
game.save!
