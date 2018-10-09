class UserService

  def find(id)
    get_json("/api/v1/users/#{id}")
  end

  private

  def conn
    Faraday.new(ENV["root_url"])
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end

end
