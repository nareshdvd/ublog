class Hooks::OrganizationAfterCreateCommitHook
  attr_reader :organization

  def initialize(organization)
    @organization = organization
  end

  def execute
    Extensions::CreateOrganizationShardExtension.new(organization).execute
  end
end
