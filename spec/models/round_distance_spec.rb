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

require 'rails_helper'

RSpec.describe RoundDistance do
  describe '#total_arrows' do
    it 'returns the total number of arrows' do
      round_distance = described_class.new(arrows_per_end: 3, ends: 2)
      expect(round_distance.total_arrows).to eql(6)
    end
  end
end
