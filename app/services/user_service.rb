class UserService
  def initialize(filter = nil)
    @filter = filter
  end

  def user_search
    get_json("/api/v1/users/#{@filter}")
  end

  private

  def conn
    Faraday.new(url: ENV['root_url']) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end