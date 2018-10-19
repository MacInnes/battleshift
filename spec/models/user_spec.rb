require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
  end

  describe 'Instance Methods' do
    context '#generate_api_key' do
      it 'generates an api key for that user' do
        user = create(:user, api_key: nil)

        expect(user.api_key).to be_nil

        user.generate_api_key

        expect(user.api_key).to_not be_nil
        expect(user.api_key).to be_a(String)
        expect(user.api_key.length).to eq(22)
      end
    end

    context 'account activation' do
      it "activates an account" do
        user = create(:user)

        expect(user.status).to eq("inactive")

        user.activate_account

        expect(user.status).to eq("active")
      end

    end
  end
end
