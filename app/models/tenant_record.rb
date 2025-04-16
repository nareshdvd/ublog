class TenantRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: Current.shard, reading: Current.shard }
end
