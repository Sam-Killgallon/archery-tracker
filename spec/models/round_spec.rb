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

require 'rails_helper'

RSpec.describe Round do
  let(:round) { described_class.new }
  let(:round_distances) do
    [
      instance_double(RoundDistance, distance: 30, total_arrows: 12),
      instance_double(RoundDistance, distance: 50, total_arrows: 36),
      instance_double(RoundDistance, distance: 70, total_arrows: 18)
    ]
  end

  before(:each) do
    allow(round).to receive(:round_distances).and_return(round_distances)
  end

  describe '#distances' do
    it 'returns the distances as an array of integers' do
      expect(round.distances).to contain_exactly(30, 50, 70)
    end
  end

  describe '#total_arrows' do
    it 'returns the total number of arrows across all rounds' do
      expect(round.total_arrows).to eql(66)
    end
  end

  describe '#max_score' do
    it 'returns the highest possible score for the round' do
      expect(round.max_score).to eql(660)
    end
  end

  describe '#as_json' do
    subject { round.as_json }
    it { is_expected.to include(distances: [30, 50, 70]) }
    it { is_expected.to include(total_arrows: 66) }
    it { is_expected.to include(max_score: 660) }
  end
end
