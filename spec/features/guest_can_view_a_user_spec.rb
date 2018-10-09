require 'rails_helper'

feature 'guest views a user' do
  context 'via /users/:id' do
    scenario 'with a valid user id' do
      visit '/users/1'

      expect(page).to have_content('Josiah Bartlet')
      expect(page).to have_content('jbartlet@example.com')
    end
  end
end