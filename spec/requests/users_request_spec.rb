require 'rails_helper'

describe "users api endpoints" do
  context "GET /api/v1/users" do
    it "returns a list of users" do
      create_list(:user, 2)

      get "/api/v1/users"

      expect(response.status).to be 200

      users = JSON.parse(response.body, symbolize_names: true)
      user  = users.first

      expect(users.count).to eq(2)
      expect(user.keys.count).to eq(3)
      expect(user).to have_key(:name)
      expect(user).to have_key(:email)
      expect(user).to have_key(:id)
    end
  end

  context "GET /api/v1/users/:id" do
    it "returns a specific user" do
      cj   = User.create!(name: "C.J. Cregg", id: 111)
      toby = User.create!(name: "Toby Ziegler", id: 222)

      get "/api/v1/users/#{cj.id}"

      expect(response.status).to be 200

      returned_user = JSON.parse(response.body, symbolize_names: true)

      expect(returned_user.keys.count).to eq(3)
      expect(returned_user).to have_key(:name)
      expect(returned_user).to have_key(:email)
      expect(returned_user).to have_key(:id)
    end
  end

  context "PATCH /api/v1/users/:id" do
    it "edits a user's email" do
      user_1 = User.create!(name: "asdf", email: "asdf@asdf.com")
      user_2 = User.create!(name: "asdf", email: "sfldfflk@aasfkhgbf.com")

      new_email = "dfkjdsf@saklfj.com"
      patch "/api/v1/users/#{user_1.id}", params: {email: new_email}

      expect(response.status).to eq(200)


    end
  end
end
