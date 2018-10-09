class UsersController < ApplicationController

  def show
    @user = UserService.find(params[:id])
    #TODO: put this into a service
    # conn = Faraday.new("http://localhost:3000")
    # response = conn.get("/api/v1/users/#{params[:id]}")
    # data = JSON.parse(response.body, symbolize_names: true)
    # @user = ResponseUser.new(data)
  end

end
