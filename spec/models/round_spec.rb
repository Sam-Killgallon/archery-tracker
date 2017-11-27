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
  let(:round) { described_class.new(round_distances: round_distances) }
  let(:round_distances) do
    [
      RoundDistance.new(distance: 30, arrows_per_end: 3, ends: 1),
      RoundDistance.new(distance: 50, arrows_per_end: 6, ends: 2),
      RoundDistance.new(distance: 70, arrows_per_end: 6, ends: 3)
    ]
  end

  describe '#distances' do
    it 'returns the distances as an array of integers' do
      expect(round.distances).to contain_exactly(30, 50, 70)
    end
  end

  describe '#total_arrows' do
    it 'returns the total number of arrows across all rounds' do
      expect(round.total_arrows).to eql(33)
    end
  end

  describe '#max_score' do
    context 'with a metric round' do
      before { round.metric = true }

      it 'uses 10 zone scoring' do
        expect(round.max_score).to eql(330)
      end
    end

    context 'with an imperial round' do
      before { round.metric = false }

      it 'uses 5 zone scoring' do
        expect(round.max_score).to eql(297)
      end
    end
  end

  describe '#as_json' do
    subject { round.as_json }
    it { is_expected.to include(round_distances: round_distances.as_json) }
    it { is_expected.to include(total_arrows: 33) }
    it { is_expected.to include(max_score: 297) }
  end
end
