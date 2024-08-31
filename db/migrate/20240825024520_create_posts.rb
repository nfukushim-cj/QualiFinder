class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.string :tool_name, null: false
      t.text :tool_description, null: false
      t.string :qualification_name, null: false
      t.string :url
      t.boolean :is_delete, null: false, default: false
      t.boolean :is_draft, null: false, default: false
      t.timestamps
    end
  end
end
