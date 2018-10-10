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
        expect(result[:email]).to eq('jbartlet@example.com')
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
        expect(result[1][:email]).to eq('jbartlet@example.com')
        expect(result[0]).to be_a(Hash)
        expect(result[0][:name]).to eq('asdf')
        expect(result[0][:email]).to eq('asdf@asdf.com')
      end
    end

    context '#update' do
      it 'updates a user' do
        stub_request(:patch, 'http://localhost:3000/api/v1/users')
          .to_return(status: 204)

        service = UserService.new
        payload_params = {
          email: 'josiah@example.com'
        }
        service.update(1, payload_params)

        file = File.open('./fixtures/users/updated_single_user.json')
        stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users/1')
          .to_return(body: file, status: 200)

        result = service.find(1)

        expect(result).to be_a(Hash)
        expect(result[:name]).to eq('Josiah Bartlet')
        expect(result[:email]).to eq('josiah@example.com')
      end
    end
  end
end
