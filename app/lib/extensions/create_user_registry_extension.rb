class Extensions::CreateUserRegistryExtension
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def execute
    UserRegistry.create!(
      organization_id: Current.organization.id,
      user_email: user.email,
      is_default: !UserRegistry.where(user_email: user.email, is_default: true).exists?
    )
  end
end
