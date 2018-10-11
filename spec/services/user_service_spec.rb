require 'rails_helper'

describe UserService do
  it 'exists' do
    result = UserService.new

    expect(result).to be_a(UserService)
  end

  context 'Instance Methods' do
    context '#find(id)' do
      it 'returns a hash with user info' do
        file = File.open('./fixtures/users/single_user_search.json')
        stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users/1')
          .to_return(body: file, status: 200)

        service = UserService.new
        result  = service.find(1)

        expect(result).to be_a(Hash)
        expect(result[:name]).to eq('Josiah Bartlet')
      end
    end

    context '#find_all' do
      it 'returns an collection of hashes' do
        file = File.open('./fixtures/users/all_user_search.json')
        stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users')
          .to_return(body: file, status: 200)

        service = UserService.new
        result  = service.find_all

        expect(result).to be_a(Array)
        expect(result[1]).to be_a(Hash)
        expect(result[1][:name]).to eq('Josiah Bartlet')
        expect(result[0]).to be_a(Hash)
        expect(result[0][:name]).to eq('asdf')
      end
    end
  end
end
