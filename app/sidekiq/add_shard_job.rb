class AddShardJob
  include Sidekiq::Job
  sidekiq_options queue: 'critical'

  def perform(organization_id)
    organization = Organization.find_by(id: organization_id)
    DynamicShards.add_organization_db_config(organization)
    DynamicShards.create_and_migrate_shard(organization)
    organization.update!(shard_added: true)
  end
end
