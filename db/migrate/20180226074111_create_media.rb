class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media do |t|
      t.string :image
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
