class Organization < PrimaryRecord
  validates_uniqueness_of :name
  validates_uniqueness_of :subdomain
  validates_uniqueness_of :shard_name

  has_many :user_registries

  after_commit -> { create_commit_hook }, on: :create

  def create_commit_hook
    Hooks::OrganizationAfterCreateCommitHook.new(self).execute
  end
end
