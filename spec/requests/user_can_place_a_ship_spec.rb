require 'rails_helper'

describe 'User places a ship' do
  context 'via POST /api/v1/games/:id/ships' do
    it 'places the first ship' do
      player1, player2 = create_list(:user, 2)
      player1.generate_api_key
      player2.generate_api_key

      payload = { opponent_email: player1.email }
      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player1.api_key }

      post '/api/v1/games', params: payload.to_json, headers: headers

      game_id = JSON.parse(response.body, symbolize_names: true)[:id]

      require 'pry'; binding.pry

      ship_1_payload = {
        ship_size: 3,
        start_space: "A1",
        end_space: "A3"
      }.to_json

      post "/api/v1/games/#{game_id}/ships", params: ship_1_payload, headers: headers

      expect(response.status).to eq(200)
    end
  end
end