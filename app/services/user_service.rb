class UserService
  attr_reader :name,
              :email

  def initialize(data)
    @name = data[:name]
    @email = data[:email]
  end

  def self.find(id)
    conn = Faraday.new("http://localhost:3000")
    response = conn.get("/api/v1/users/#{id}")
    data = JSON.parse(response.body, symbolize_names: true)
    UserService.new(data)
  end

end
