class UserService

  def find(id)
    get_json("/api/v1/users/#{id}")
  end

  def find_all
    get_json("api/v1/users")
  end

  private

  def conn
    Faraday.new("http://enigmatic-gorge-11732.herokuapp.com")
  end

  def get_json(url)
    response = conn.get(url)

    if response.status != 404
      JSON.parse(response.body, symbolize_names: true)
    end
  end

end
