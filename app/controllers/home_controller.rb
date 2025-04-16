class HomeController < ApplicationController
  def index
    render json: User.all.as_json(only: [:id, :email])
  end
end
