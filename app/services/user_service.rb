class UserService

  def find(id)
    get_json("/api/v1/users/#{id}")
  end

  def find_all
    get_json("/api/v1/users")
  end

  def update(id, email)
    update_json("/api/v1/users/#{id}", email)
  end

  private

  def conn
    Faraday.new(ENV["root_url"])
  end

  def update_json(url, payload)
    response = conn.patch(url, payload)
  end

  def get_json(url)
    response = conn.get(url)

    if response.status != 404
      JSON.parse(response.body, symbolize_names: true)
    end
  end

end
