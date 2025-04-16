class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_current_organization

  def set_current_organization
    subdomain = request.subdomains.first
    return if subdomain.blank?

    organization = Organization.find_by(subdomain: subdomain)
    Current.organization = organization
  end
end
