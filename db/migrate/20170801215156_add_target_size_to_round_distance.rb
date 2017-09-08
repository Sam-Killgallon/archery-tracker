class AddTargetSizeToRoundDistance < ActiveRecord::Migration[5.1]
  def change
    add_column :round_distances, :target_size, :integer
  end
end
