require 'rails_helper'

feature 'Guest views a user' do
  context 'via /users/:id' do
    scenario 'with a valid user id' do
      file = File.open('./fixtures/users/single_user_search.json')
      stub_request(:get, "https://enigmatic-gorge-11732.herokuapp.com/api/v1/users/1").
        with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v0.15.3'
           })
        .to_return(body: file, status: 200)

      visit '/users/1'

      expect(page).to have_content('Josiah Bartlet')
      expect(page).to have_content('jbartlet@example.com')
    end

    scenario 'with an invalid user id' do
      #TODO: figure out how to test 404 response with webmock/vcr
      stub_request(:get, "https://enigmatic-gorge-11732.herokuapp.com/api/v1/users/1000").
        with(
          headers: {
     	   'Accept'=>'*/*',
     	   'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     	   'User-Agent'=>'Faraday v0.15.3'
         })
        .to_return(status: 400)

      visit '/users/1000'

      expect(page.status_code).to be(400)
    end
  end
end
