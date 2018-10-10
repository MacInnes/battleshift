require 'rails_helper'

feature 'Guest views a user' do
  context 'via /users/:id' do
    scenario 'with a valid user id' do
      file = File.open('./fixtures/users/single_user_search.json')
      stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users/1')
        .to_return(body: file, status: 200)

      visit '/users/1'

      expect(page).to have_content('Josiah Bartlet')
      expect(page).to have_content('jbartlet@example.com')
    end

    scenario 'with an invalid user id' do
      stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users/1000')
        .to_return(status: 400)

      visit '/users/1000'

      expect(response.status).to be(400)
    end
  end
end