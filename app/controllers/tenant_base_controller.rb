class TenantBaseController < ApplicationController
  before_action :set_current_organization
  layout 'tenant'

  def set_current_organization
    subdomain = request.subdomains.first
    user_default_subdomain = UserRegistry.find_by(user_email: current_user.email, is_default: true).organization.subdomain
    if subdomain.blank? || subdomain != user_default_subdomain
      redirect_to root_url(subdomain: user_default_subdomain) and return
    end

    organization = Organization.find_by(subdomain: subdomain)
    Current.organization = organization
  end
end
