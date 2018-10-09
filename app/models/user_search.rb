class UserSearch

  def initialize
  end

  def find_user(id)
    User.new(service.find(id))
  end

  private

  def service
    UserService.new
  end
end
