require 'rails_helper'

feature 'guest user' do
  scenario 'edits /user/1' do
    visit '/users'

    within('#user_1') do
      click_on "Edit"
    end

    expect(current_path).to eq("/users/1/edit")

    fill_in :email, with: "josiah@example.com"
    click_on "Save"

    expect(current_path).to eq("/users")
    expect(page).to have_content("Successfully updated Josiah Bartlet.")

    within('#user_1') do
      expect(page).to have_content("josiah@example.com")
    end
  end
end
