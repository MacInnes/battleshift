require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'Relationships' do
    it { should belong_to(:player_1).class_name('User').with_foreign_key('player_1_id') }
    it { should belong_to(:player_2).class_name('User').with_foreign_key('player_2_id') }
  end

  describe 'Validations' do
    it { should validate_presence_of :player_1 }
  end

  describe 'instance methods' do
    it "change_turn" do
      player_1 = create(:user)
      player_2 = create(:user, api_key: "asdf")
      game = create(:game, player_1_id: player_1.id, player_2_id: player_2.id)

      expect(game.current_turn).to eq("player_1")
      game.change_turn
      expect(game.current_turn).to eq("player_2")
      game.change_turn
      expect(game.current_turn).to eq("player_1")
    end
  end
end
