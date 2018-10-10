class UserSearch

  def find_user(id)
    User.new(service.find(id))
  end

  def find_all_users
    service.find_all.map do |user_hash|
      User.new(user_hash)
    end
  end

  private

  def service
    UserService.new
  end

end
