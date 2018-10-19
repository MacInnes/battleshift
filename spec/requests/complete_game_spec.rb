require 'rails_helper'

describe 'A complete 2-player game' do
  it "can finish a complete game" do
    player_1 = create(:user)
    player_2 = create(:user, api_key: "asdf", email: "player_2@example.com")
    game = create(:game, player_1_id: player_1.id, player_2_id: player_2.id)

    headers_1 = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player_1.api_key }
    headers_2 = { "CONTENT_TYPE" => "application/json", "X-API-KEY" => player_2.api_key }

    ship_1_payload = {
      ship_size: 3,
      start_space: "A1",
      end_space: "A3"
    }.to_json

    ship_2_payload = {
      ship_size: 2,
      start_space: "B1",
      end_space: "B2"
    }.to_json

    ship_3_payload = {
      ship_size: 3,
      start_space: "A1",
      end_space: "A3"
    }.to_json

    ship_4_payload = {
      ship_size: 2,
      start_space: "B1",
      end_space: "B2"
    }.to_json

    #ship placement

    post "/api/v1/games/#{game.id}/ships", params: ship_1_payload, headers: headers_1
    result = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(result[:message]).to include("Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.")

    post "/api/v1/games/#{game.id}/ships", params: ship_2_payload, headers: headers_1
    result = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(result[:message]).to include("Successfully placed ship with a size of 2. You have 0 ship(s) to place.")

    post "/api/v1/games/#{game.id}/ships", params: ship_3_payload, headers: headers_2
    result = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(result[:message]).to include("Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.")

    post "/api/v1/games/#{game.id}/ships", params: ship_4_payload, headers: headers_2
    result = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(result[:message]).to include("Successfully placed ship with a size of 2. You have 0 ship(s) to place.")

    # shots
    #player 1

    target = {target: "A1"}.to_json
    post "/api/v1/games/#{game.id}/shots", params: target, headers: headers_1
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result[:message]).to include("Your shot resulted in a Hit")

    #player 2

    target = {target: "D1"}.to_json
    post "/api/v1/games/#{game.id}/shots", params: target, headers: headers_2
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result[:message]).to include("Your shot resulted in a Miss")

    #player 1

    target = {target: "A2"}.to_json
    post "/api/v1/games/#{game.id}/shots", params: target, headers: headers_1
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result[:message]).to include("Your shot resulted in a Hit")

    #player 1 again OUT OF TURN

    target = {target: "C2"}.to_json
    post "/api/v1/games/#{game.id}/shots", params: target, headers: headers_1
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(result[:message]).to include("Invalid move. It's your opponent's turn")

    #player 2

    target = {target: "D2"}.to_json
    post "/api/v1/games/#{game.id}/shots", params: target, headers: headers_2
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result[:message]).to include("Your shot resulted in a Miss")

    #player 1

    target = {target: "A3"}.to_json
    post "/api/v1/games/#{game.id}/shots", params: target, headers: headers_1
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result[:message]).to include("Your shot resulted in a Hit. Battleship sunk.")

    #player 2

    target = {target: "D3"}.to_json
    post "/api/v1/games/#{game.id}/shots", params: target, headers: headers_2
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result[:message]).to include("Your shot resulted in a Miss")

    #player 1

    target = {target: "B1"}.to_json
    post "/api/v1/games/#{game.id}/shots", params: target, headers: headers_1
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result[:message]).to include("Your shot resulted in a Hit")

    #player 2

    target = {target: "D4"}.to_json
    post "/api/v1/games/#{game.id}/shots", params: target, headers: headers_2
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result[:message]).to include("Your shot resulted in a Miss")

    #player 1

    target = {target: "B2"}.to_json
    post "/api/v1/games/#{game.id}/shots", params: target, headers: headers_1
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result[:message]).to include("Your shot resulted in a Hit. Battleship sunk. Game over.")

    #player 2 shoots after game finished

    target = {target: "C4"}.to_json
    post "/api/v1/games/#{game.id}/shots", params: target, headers: headers_2
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(result[:message]).to include("Invalid move. Game over.")
  end
end
