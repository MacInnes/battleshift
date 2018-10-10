require 'rails_helper'

feature 'Guest views all users' do
  context 'via /users' do
    scenario 'returns an index of all users' do
      file = File.open('./fixtures/users/all_user_search.json')
      stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users')
        .to_return(body: file, status: 200)

      visit '/users'

      within("#user_1") do
        expect(page).to have_content('Josiah Bartlet')
      end

      within("#user_2") do
        expect(page).to have_content('asdf')
      end

    end
  end
end
