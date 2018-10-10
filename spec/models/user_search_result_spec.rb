require 'rails_helper'

describe UserSearchResult do
  it 'exists' do
    result = UserSearchResult.new(1)

    expect(result).to be_a(UserSearchResult)
  end

  context 'Instance Methods' do
    context '#user' do
      it 'returns a single specified user' do
        result = UserSearchResult.new(1).user

        expect(result).to be_a(User)
        expect(result.name).to eq('Josiah Bartlet')
        expect(result.email).to eq('jbartlet@example.com')
      end
    end

    context '#users' do
      it 'returns a collection of all users' do
        result = UserSearchResult.new.users

        expect(result).to all(be_a(User))
        expect(result[0].name).to eq('asdf')
        expect(result[0].email).to eq('asdf@asdf.com')
        expect(result[1].name).to eq('Josiah Bartlet')
        expect(result[1].email).to eq('jbartlet@example.com')
      end
    end
  end
end