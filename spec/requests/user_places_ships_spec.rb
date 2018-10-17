require 'rails_helper'

describe 'User places ships' do
  context 'via POST /api/v1/games/:game_id/ships' do
    it 'places a ship' do
      player_1, player_2 = create_list(:user, 2)
      player_1.generate_api_key
      player_2.generate_api_key

      game = create(:game, player_1_key: player_1.api_key, player_2_key: player_2.api_key, player_1: player_1, player_2: player_2)

      ship_1_payload = {
        ship_size: 3,
        start_space: "A1",
        end_space: "A3"
      }.to_json

      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player_1.api_key }

      post "/api/v1/games/#{game.id}/ships", params: ship_1_payload, headers: headers

      expect(response.status).to eq(200)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:message]).to include("Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.")
    end
  end
end
