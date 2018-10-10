class UserService

  def find(id)
    get_json("/api/v1/users/#{id}")
  end

  def find_all
    get_json("api/v1/users")
  end

  def update(id, email)
    patch_json("api/v1/users/#{id}", id, email)
  end

  private

  def conn
    Faraday.new("http://localhost:3000")
  end

  def get_json(url)
    response = conn.get(url)

    if response.status != 404
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  def patch_json(url, id, email)
    response = conn.patch(url) do |req|
      req.body = {email: email, id: id}
    end
  end

end
