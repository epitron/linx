class CreateTags < ActiveRecord::Migration
  def change

    create_table :tags do |t|
      t.string :name
      t.index :name

      t.integer :links_count
      t.index :links_count
    end
    
    # create_join_table :links, :tags
    create_join_table :links, :tags do |t|
      t.index :link_id
      t.index :tag_id
    end
  end
end
