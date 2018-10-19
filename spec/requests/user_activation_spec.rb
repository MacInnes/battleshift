require 'rails_helper'

describe 'User Validation' do
  it "validates a user" do
    user = create(:user)
    user.generate_api_key

    expect(user.status).to eq("inactive")

    get "/activate_user?user=#{user.id}&key=#{user.api_key}"

    expect(response).to redirect_to('/dashboard')
  end
end
