class AddPlayerKeysToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :player_1_key, :string
    add_column :games, :player_2_key, :string
  end
end
