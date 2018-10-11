require 'rails_helper'

feature 'Guest edits a user' do
  context 'via /users/:id/edit' do
    scenario 'to update email only' do
      # When I visit "/users"
      visit '/users'
      # And I click on `Edit` for Josiah Bartlet
      within('#user_1') do
        click_on 'Edit'
      end
      # Then I should be on "/users/1/edit"
      expect(current_path).to eq('/users/1/edit')

      # When I fill in the email field with "josiah@example.com"
      fill_in "email", with: 'josiah@example.com'
      # And I click "Save"

      # Load the updated stub
      file = File.open('./fixtures/users/updated_all_users.json')
      stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users')
        .to_return(body: file, status: 200)

      click_on 'Save'

      # Then I should be on "/users"X
      expect(current_path).to eq('/users')
      # And I should see a flash message that says "Successfully updated Josiah Bartlet."
      expect(page).to have_content('Successfully updated Josiah Bartlet')
      # And I should should see Josiah Bartlet's email show up in the list as "josiah@example.com"
      within('#user_1') do
        expect(page).to have_content('josiah@example.com')
      end
    end
  end  
end