class UserService

  def find(id)
    get_json("/api/v1/users/#{id}")
  end

  def find_all
    get_json("api/v1/users")
  end

  private

  def conn
    Faraday.new("http://localhost:3000")
    # Faraday.new("https://enigmatic-gorge-11732.herokuapp.com/")

  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

end
