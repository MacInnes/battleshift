require 'rails_helper'

feature 'Guest views all users' do
  context 'via /users' do
    scenario 'returns an index of all users' do
      file = File.open('./fixtures/users/all_user_search.json')
      stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users')
        .to_return(body: file, status: 200)

      visit '/users'

      # within("#user_1") do
      #   expect(page).to have_content('Josiah Bartlet')
      #   expect(page).to have_content('jbartlet@example.com')
      # end

      # within("#user_2") do
      #   expect(page).to have_content('asdf')
      #   expect(page).to have_content('asdf@asdf.com')
      # end

      expect(page).to have_css('.user', count: 2)

      within('#user_1') do
        expect(page).to have_css('.user-name')
        expect(page).to have_css('.user-email')
      end

    end
  end
end
