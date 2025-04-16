class Extensions::CreateOrganizationShardExtension
  attr_reader :organization

  def initialize(organization)
    @organization = organization
  end

  def execute
    AddShardJob.perform_async(organization.id)
  end
end
