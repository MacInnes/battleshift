require 'rails_helper'

describe 'User creates a game' do
  context 'via POST /api/v1/games' do
    it 'creates a game' do
      player1, player2 = create_list(:user, 2)
      player1.generate_api_key
      player2.generate_api_key

      payload = { opponent_email: player1.email }
      headers = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player1.api_key }

      post '/api/v1/games', params: payload.to_json, headers: headers

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(result[:id]).to eq(Game.last.id)
    end
  end
end