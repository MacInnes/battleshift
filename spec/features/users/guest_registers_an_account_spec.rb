require 'rails_helper'

feature 'Guest creates an account' do
  context 'via /register' do
    scenario 'successfully registers with valid fields entered' do
      visit '/'
      click_on 'Register'

      expect(current_path).to eq('/register')

      user_name = 'Test'

      fill_in :user_email, with: 'test@example.com'
      fill_in :user_name, with: user_name
      fill_in :password, with: 'testpass'
      fill_in :password_confirmation, with: 'testpass'
      click_on 'Submit'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Logged in as #{user_name}")
      expect(page).to have_content('This account has not yet been acticvated. Please check your email.')
    end

    scenario 'unsuccessfully creates with required fields not entered' do
      visit '/register'

      fill_in :user_email, with: ''
      fill_in :user_name, with: ''
      fill_in :password, with: ''
      fill_in :password_confirmation, with: ''
      click_on 'Submit'

      expect(current_path).to eq('/register')
      expect(page).to have_content('Invalid registration details.')
    end
  end
end