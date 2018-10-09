require 'rails_helper'

feature 'guest views a user' do
  context 'via /users/:id' do
    scenario 'with a valid user id' do
      # When I visit "/users/1"
      visit '/users/1'

      # Then I should see the user's name Josiah Bartlet
      expect(page).to have_content('Josiah Bartlet')

      # And I should see the user's email address jbartlet@example.com
      expect(page).to have_content('jbartlet@example.com')
    end
  end
end