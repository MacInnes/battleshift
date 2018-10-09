class UserService

  def self.find(id)
    conn = Faraday.new(ENV["root_url"])
    response = conn.get("/api/v1/users/#{id}")
    data = JSON.parse(response.body, symbolize_names: true)
    User.new(data)
  end

end
