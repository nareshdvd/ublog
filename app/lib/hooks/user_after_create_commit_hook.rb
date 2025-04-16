class Hooks::UserAfterCreateCommitHook
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def execute
    Extensions::CreateUserRegistryExtension.new(user).execute
  end
end
