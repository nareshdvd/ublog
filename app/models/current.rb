class Current < ActiveSupport::CurrentAttributes
  attr_reader :organization

  def organization=(org)
    @organization = org
    DynamicShards.add_organization_db_config(organization)
    TenantRecord.connects_to database: { writing: shard, reading: shard }
    organization
  end

  def shard
    s = organization&.shard_name&.to_sym || :primary
    return s
  end
end
