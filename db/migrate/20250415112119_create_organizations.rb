class CreateOrganizations < ActiveRecord::Migration[7.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :subdomain
      t.string :shard_name
      t.boolean :shard_added, default: false

      t.timestamps
    end
  end
end
