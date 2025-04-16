class AddIsDefaultToUserRegistries < ActiveRecord::Migration[7.2]
  def change
    add_column :user_registries, :is_default, :boolean, default: false
  end
end
