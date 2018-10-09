require 'rails_helper'

feature 'guest user visits' do
  scenario '/users/1' do
    VCR.use_cassette("single_user") do
      visit '/users/1'

      expect(current_path).to eq("/users/1")
      expect(page).to have_css(".user", count: 1)
    end

  end
end
