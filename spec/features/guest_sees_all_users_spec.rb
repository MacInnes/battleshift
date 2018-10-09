require 'rails_helper'

feature 'guest' do
  scenario 'visits /users' do

    VCR.use_cassette("multi_user_find") do
      visit '/users'


      expect(current_path).to eq("/users")
      expect(page).to have_content("Josiah Bartlet")
      expect(page).to have_content("jbartlet@example.com")
      expect(page).to have_content("asdf")
      expect(page).to have_content("asdf@asdf.com")
    end
  end
end
