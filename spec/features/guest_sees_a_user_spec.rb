require 'rails_helper'

feature 'guest user visits' do
  scenario '/users/1' do
    VCR.use_cassette("single_user_find") do
      visit '/users/1'

      expect(current_path).to eq("/users/1")
      expect(page).to have_content("Josiah Bartlet")
      expect(page).to have_content("jbartlet@example.com")
    end

  end
end
