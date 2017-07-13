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

RSpec.describe Round, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
