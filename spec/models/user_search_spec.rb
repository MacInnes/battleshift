require 'rails_helper'

describe UserSearch do
  it 'exists' do
    search = UserSearch.new

    expect(search).to be_a(UserSearch)
  end

  context 'Instance Methods' do
    context '#find_user(id)' do
      it 'returns a single user' do
        file = File.open('./fixtures/users/single_user_search.json')
        stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users/1')
          .to_return(body: file, status: 200)

        search = UserSearch.new
        result = search.find_user(1)

        expect(result).to be_a(User)
        expect(result.name).to eq('Josiah Bartlet')
      end
    end

    context '#find_all_users' do
      it 'returns all users' do
        file = File.open('./fixtures/users/all_user_search.json')
        stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users')
          .to_return(body: file, status: 200)

        search = UserSearch.new
        result = search.find_all_users

        expect(result).to be_a(Array)
        expect(result[1]).to be_a(User)
        expect(result[1].name).to eq('Josiah Bartlet')
        expect(result[0]).to be_a(User)
        expect(result[0].name).to eq('asdf')
      end
    end
  end
end
