class ApplicationController < ActionController::Base
  include Pundit::Authorization

  allow_browser versions: :modern
  before_action :authenticate_user!

  def page
    (params[:page] || '1').to_i
  end

  def per_page
    (params[:per_page] || '20').to_i
  end
end
