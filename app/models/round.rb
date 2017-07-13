# == Schema Information
#
# Table name: rounds
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  indoor     :boolean
#  metric     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Round < ApplicationRecord
  has_many :round_distances, dependent: :destroy

  def distances
    round_distances.map(&:distance)
  end

  def total_arrows
    round_distances.reduce(0) { |total, distance| total + distance.total_arrows }
  end

  def max_score
    # FIXME: Not valid for all rounds
    total_arrows * 10
  end

  def as_json(options = {})
    super.merge(
      distances: distances,
      total_arrows: total_arrows,
      max_score: max_score
    )
  end
end
