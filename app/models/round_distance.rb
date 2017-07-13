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
#

class RoundDistance < ApplicationRecord
  belongs_to :round

  # FIXME: Should contain target size as well

  def total_arrows
    arrows_per_end * ends
  end
end
