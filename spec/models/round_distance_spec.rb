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

RSpec.describe RoundDistance, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
