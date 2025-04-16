# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user_registry = UserRegistry.find_by(user_email: params[:user][:email], is_default: true)
    if user_registry.blank?
      flash[:alert] = "Registration not found"
      render :new and return
    end
    Current.organization = user_registry.organization
    super do |user|
      subdomain_url = root_url(subdomain: user_registry.organization.subdomain)
      return render turbo_stream: turbo_stream.redirect(subdomain_url) if turbo_frame_request?

      return redirect_to subdomain_url, allow_other_host: true, status: :see_other
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super do
      url = new_user_session_url(subdomain: nil)
      return render turbo_stream: turbo_stream.redirect(url) if turbo_frame_request?

      return redirect_to url, allow_other_host: true, status: :see_other
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
