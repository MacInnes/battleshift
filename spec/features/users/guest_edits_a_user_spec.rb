require 'rails_helper'

feature 'Guest edits a user' do
  context 'via /users/:id/edit' do
    scenario 'to update email only' do
      stub_request(:patch, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users/1')
        .to_return(status: 200)

      visit '/users'

      within('#user_1') do
        click_on 'Edit'
      end

      expect(current_path).to eq('/users/1/edit')

      fill_in "email", with: 'josiah@example.com'

      file = File.open('./fixtures/users/updated_all_users.json')
      stub_request(:get, 'http://enigmatic-gorge-11732.herokuapp.com/api/v1/users')
        .to_return(body: file, status: 200)

      click_on 'Save'

      expect(current_path).to eq('/users')
      expect(page).to have_content('Successfully updated Josiah Bartlet')
      within('#user_1') do
        expect(page).to have_content('josiah@example.com')
      end
    end
  end  
end