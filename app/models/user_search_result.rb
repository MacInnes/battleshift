class UserSearchResult
  def initialize(user_id = nil)
    @user_id = user_id
  end

  def user
    conn = Faraday.new(url: ENV['root_url']) do |faraday|
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/api/v1/users/#{@user_id}")
    user_data = JSON.parse(response.body, symbolize_names: true)

    User.new(user_data)
  end
end