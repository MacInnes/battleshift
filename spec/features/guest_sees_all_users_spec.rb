require 'rails_helper'

feature 'guest' do
  scenario 'visits /users' do

    VCR.use_cassette("multi_user_find") do
      visit '/users'


      expect(current_path).to eq("/users")
      expect(page).to have_css(".user", count: 2)
    end
  end
end
