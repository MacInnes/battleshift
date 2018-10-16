require 'rails_helper'

describe 'User places a ship' do
  context 'via POST /api/v1/games/:id/ships' do
    it 'places the first ship' do
      player1, player2 = create_list(:user, 2)
      player1.generate_api_key
      player2.generate_api_key

      game = create(:game, player_1: player1, player_2: player2)

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player1.api_key }

      ship_1_payload = {
        ship_size: 3,
        start_space: "A1",
        end_space: "A3"
      }.to_json

      post "/api/v1/games/#{game.id}/ships", params: ship_1_payload, headers: headers

      expect(response.status).to eq(200)

      require 'pry'; binding.pry
    end
  end
end