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
    metric ? total_arrows * 10 : total_arrows * 9
  end

  def as_json(options = {})
    super.merge(
      round_distances: round_distances.as_json,
      total_arrows: total_arrows,
      max_score: max_score
    )
  end
end
