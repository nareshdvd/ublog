class User < TenantRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_commit -> { create_commit_hook }, on: :create

  def create_commit_hook
    Hooks::UserAfterCreateCommitHook.new(self).execute
  end
end
