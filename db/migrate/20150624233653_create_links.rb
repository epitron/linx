class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.index :title

      t.string :url
      t.index :url

      t.string :description
      t.index :description

      t.integer :user_id
      t.index :user_id

      t.timestamps null: false
      t.index :created_at
    end
  end
end
