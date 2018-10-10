require 'rails_helper'

feature 'guest' do
  scenario 'edits a user' do
    visit '/users'

    within('#user_1') do
      click_on "Edit"
    end

    expect(current_path).to eq("/users/1/edit")

    fill_in "Email", with: "josiah@example.com"
    click_on "Save"

    expect(current_path).to eq("/users")
    expect(page).to have_content("Successfully updated Josiah Bartlet.")

    within('#user_1') do
      expect(page).to have_content("josiah@example.com")
    end
  end
end
