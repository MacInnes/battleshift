require 'rails_helper'

feature 'guest views a user' do
  context 'via /users/:id' do
    scenario 'with a valid user id' do
      user = create(:user)

      # When I visit "/users/1"
      visit '/users/1'

      # Then I should see the user's name Josiah Bartlet
      expect(page).to have_content(user.name)

      # And I should see the user's email address jbartlet@example.com
      expect(page).to have_content(user.email)
    end
  end
end