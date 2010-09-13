class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.integer :author_id, :default => 1
      t.text :intro
      t.text :body
      t.integer :duration
      t.integer :min_cost
      t.integer :max_cost
      t.float :rating
      t.boolean :can_reuse, :null => false, :default => false
      t.boolean :is_significant, :null => false, :default => false
      t.boolean :active, :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
