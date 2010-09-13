class CreateMailings < ActiveRecord::Migration
  def self.up
    create_table :mailings do |t|
      t.integer :smoochee_id
      t.integer :article_id
      t.datetime :time_sent
      t.timestamps
    end
  end

  def self.down
    drop_table :mailings
  end
end
