class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.integer :link_id
      t.index :link_id

      t.timestamps null: false
    end
  end
end
