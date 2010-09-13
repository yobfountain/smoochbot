class CreateSmoochees < ActiveRecord::Migration
  def self.up
    create_table :smoochees do |t|
      t.string :email
      t.boolean :email_verified
      t.boolean :active
      t.date :anniversary
      t.date :birthday
      t.integer :budget
      t.integer :frequency
      t.datetime :last_smooched
      t.string :confirmation_code
      t.timestamps
    end
  end

  def self.down
    drop_table :smoochees
  end
end
