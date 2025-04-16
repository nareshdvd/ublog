class CreateUserRegistries < ActiveRecord::Migration[7.2]
  def change
    create_table :user_registries do |t|
      t.bigint :organization_id
      t.string :user_email

      t.timestamps
    end
  end
end
