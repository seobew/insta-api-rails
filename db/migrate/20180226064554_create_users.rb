class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password
      t.integer :total_follower
      t.integer :total_followee

      t.timestamps
    end
  end
end
