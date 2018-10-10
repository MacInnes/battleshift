require 'rails_helper'

feature 'Guest views all users' do
  context 'via /users' do
    scenario 'returns an index of all users' do
      file = File.open('./fixtures/user/all_user_search.json')
      stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users/1')
        .to_return(body: file, status: 200)

      visit '/users'

      expect(page).to have_content('Josiah Bartlet')
      expect(page).to have_content('jbartlet@example.com')
      expect(page).to have_content('asdf')
      expect(page).to have_content('asdf@asdf.com')
    end
  end
end