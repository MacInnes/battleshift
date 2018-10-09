require 'rails_helper'

feature 'guest views all users' do
  context 'via /users' do
    scenario 'shows a list of all users' do
      # When I visit "/users"
      visit '/users'
      # Then I should see the user's name (for both users)
      expect(page).to have_content('Josiah Bartlet')
      expect(page).to have_content('asdf')
      # And I should see the user's email (for both users)
      expect(page).to have_content('jbartlet@example.com')
      expect(page).to have_content('asdf@asdf.com')
    end
  end
end