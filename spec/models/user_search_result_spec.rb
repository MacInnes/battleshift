require 'rails_helper'

describe UserSearchResult do
  it 'exists' do
    result = UserSearchResult.new(1)

    expect(result).to be_a(UserSearchResult)
  end

  context 'Instance Methods' do
    context '#user' do
      it 'returns a single specified user' do
        result = UserSearchResult.new(1)

        expect(result.user).to be_a(User)
        expect(result.user.name).to eq('Josiah Bartlet')
        expect(result.user.email).to eq('jbartlet@example.com')
      end
    end
  end
end