require 'rails_helper'

describe UserService do
  it 'exists' do
    service = UserService.new(1)

    expect(service).to be_a(UserService)
  end

  context 'Instance Methods' do
    context '#user_search' do
      it 'returns a hash if new is an integer' do
        file = File.open("./fixtures/users/single_user_search.json")
    
        stub_request(:get, "http://enigmatic-gorge-11732.herokuapp.com/api/v1/users/1").
          to_return(body: file, status: 200)

        service = UserService.new(1)

        expect(service.user_search).to be_a(Hash)
        expect(service.user_search).to have_key(:id)
        expect(service.user_search).to have_key(:name)
        expect(service.user_search).to have_key(:email)
      end

      it 'returns a collection of hashes if new is nil' do
        file = File.open("./fixtures/users/all_user_search.json")
    
        stub_request(:get, "http://enigmatic-gorge-11732.herokuapp.com/api/v1/users/").
          to_return(body: file, status: 200)

        service = UserService.new

        expect(service.user_search).to be_a(Array)
        expect(service.user_search.first).to be_a(Hash)
        expect(service.user_search[1]).to be_a(Hash)
      end
    end
  end
end