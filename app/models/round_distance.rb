# == Schema Information
#
# Table name: round_distances
#
#  id             :integer          not null, primary key
#  distance       :integer
#  ends           :integer
#  arrows_per_end :integer
#  round_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  target_size    :integer
#

class RoundDistance < ApplicationRecord
  belongs_to :round

  def total_arrows
    arrows_per_end * ends
  end

  def as_json(options = {})
    super.merge(total_arrows: total_arrows)
  end
end
