class CreateRoundDistances < ActiveRecord::Migration[5.1]
  def change
    create_table :round_distances do |t|
      t.integer :distance
      t.integer :ends
      t.integer :arrows_per_end
      t.references :round, foreign_key: true, index: true

      t.timestamps
    end
  end
end
