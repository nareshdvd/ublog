module DynamicShards
  def self.application_after_initialize
    if Organization.connection.database_exists? && Organization.table_exists?
      Organization.all.each do |organization|
        self.create_and_migrate_shard(organization)
      end
    end
  end

  def self.get_db_config(shard_name)
    ActiveRecord::DatabaseConfigurations::HashConfig.new(
      Rails.env,
      shard_name,
      Rails.configuration.database_configuration[Rails.env]["primary"].deep_merge("database" => shard_name)
    )
  end

  def self.add_organization_db_config(organization)
    shard_name = organization.shard_name
    db_config = get_db_config(shard_name)
    return db_config if ActiveRecord::Base.configurations.configs_for(env_name: Rails.env, name: shard_name).present?

    ActiveRecord::Base.configurations.configurations << db_config
    # ActiveRecord::Base.establish_connection(shard_name.to_sym)
    return db_config
  end

  def self.create_and_migrate_shard(organization)
    db_config = self.add_organization_db_config(organization)
    self.create_shard(db_config)
    self.migrate_shard(db_config)
  end

  def self.create_shard(db_config)
    if !self.db_exists?(db_config.configuration_hash[:database])
      ActiveRecord::Base.establish_connection(:primary)
      ActiveRecord::Base.connection.create_database(db_config.configuration_hash[:database])
    end
  end

  def self.db_exists?(db_name)
    ActiveRecord::Base.connection.execute("SELECT FROM pg_database WHERE datname = '#{db_name}'").ntuples.positive?
  end

  def self.migrate_shard(db_config)
    ActiveRecord::Base.establish_connection(db_config.configuration_hash[:database].to_sym)
    migrations_paths = Rails.application.paths["db/migrate"].to_a
    migration_context = ActiveRecord::MigrationContext.new(migrations_paths)
    migration_context.up
  end
end

Rails.application.config.after_initialize do
  DynamicShards.application_after_initialize
end
