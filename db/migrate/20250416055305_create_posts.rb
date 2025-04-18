class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.bigint :author_id
      t.datetime :published_at

      t.timestamps
    end
  end
end
