class CreateRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :rounds do |t|
      t.string :name
      t.boolean :indoor
      t.boolean :metric

      t.timestamps
    end
    add_index :rounds, :name, unique: true
  end
end
