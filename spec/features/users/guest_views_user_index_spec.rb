require 'rails_helper'

feature 'Guest views all users' do
  context 'via /users' do
    scenario 'returns an index of all users' do
      file = File.open('./fixtures/users/all_user_search.json')
      stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users')
        .to_return(body: file, status: 200)

      visit '/users'

      expect(page).to have_css(".user", count: 2)
      expect(page).to have_css("#user_1", count: 1)
      expect(page).to have_css("#user_2", count: 1)
    end
  end
end
