class UserSearchResult
  def initialize(user_id = nil)
    @user_id = user_id
  end

  def user
    user_data = service.user_search

    User.new(user_data)
  end

  def users
    service.user_search.map do |user_data|
      User.new(user_data)
    end
  end

  private

  def service
    UserService.new(@user_id)
  end
end