FactoryBot.define do
  factory :user do
    name { "Josiah Bartlet" }
    sequence(:email) { |n| "jbartlet#{n}@example.com" }
    address { "1600 Pennsylvania Ave NW, Washington, DC 20500" }
    password {"asdf"}
    password_confirmation {"asdf"}
    phone { 555555555 }
    api_key { "111111" }
  end
end
