require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'Relationships' do
    it { should belong_to(:player_1).class_name('User').with_foreign_key('player_1_id') }
    it { should belong_to(:player_2).class_name('User').with_foreign_key('player_2_id') }
  end

  describe 'Validations' do
    it { should validate_presence_of :player_1 }
  end
end
