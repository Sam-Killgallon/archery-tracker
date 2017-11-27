# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Round.destroy_all

### Indoor Metric ###
Round.create!(name: 'FITA 18', indoor: true, metric: true).tap do |round|
  RoundDistance.create!(distance: 18, ends: 20, arrows_per_end: 3, round: round, target_size: 40)
end

Round.create!(name: 'FITA 25', indoor: true, metric: true).tap do |round|
  RoundDistance.create!(distance: 25, ends: 20, arrows_per_end: 3, round: round, target_size: 60)
end

Round.create!(name: 'FITA Combined', indoor: true, metric: true).tap do |round|
  RoundDistance.create!(distance: 25, ends: 20, arrows_per_end: 3, round: round, target_size: 60)
  RoundDistance.create!(distance: 18, ends: 20, arrows_per_end: 3, round: round, target_size: 40)
end

Round.create!(name: 'Stafford', indoor: true, metric: true).tap do |round|
  RoundDistance.create!(distance: 30, ends: 24, arrows_per_end: 3, round: round, target_size: 80)
end

# Vegas is special due to different scoring and shooting rules
# Round.create!(name: 'Vegas', indoor: true, metric: true).tap do |round|
#   RoundDistance.create!(distance: 18, ends: 20, arrows_per_end: 3, round: round, target_size: 40)
# end


### Outdoor Metric ###
Round.create!(name: 'FITA 1440', indoor: false, metric: true).tap do |round|
  RoundDistance.create!(distance: 90, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 70, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 50, ends: 12, arrows_per_end: 3, round: round, target_size: 80)
  RoundDistance.create!(distance: 30, ends: 12, arrows_per_end: 3, round: round, target_size: 80)
end


### Indoor Imperial ###
# Worcester is special due to different scoring and shooting rules
# Round.create!(name: 'Worcester', indoor: true, metric: false).tap do |round|
#   RoundDistance.create!(distance: 20, ends: 12, arrows_per_end: 5, round: round, target_size: 40.6)
# end

Round.create!(name: 'Portsmouth', indoor: true, metric: false).tap do |round|
  RoundDistance.create!(distance: 20, ends: 20, arrows_per_end: 3, round: round, target_size: 60)
end

Round.create!(name: 'Bray I', indoor: true, metric: false).tap do |round|
  RoundDistance.create!(distance: 20, ends: 10, arrows_per_end: 3, round: round, target_size: 40)
end

Round.create!(name: 'Bray II', indoor: true, metric: false).tap do |round|
  RoundDistance.create!(distance: 25, ends: 10, arrows_per_end: 3, round: round, target_size: 60)
end



### Outdoor Imperial ###
Round.create!(name: 'Albion', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 80, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 60, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 50, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'York', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 100, ends: 12, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 80, ends: 8, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 60, ends: 4, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'Hereford', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 80, ends: 12, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 60, ends: 8, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 50, ends: 4, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'St. George', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 80, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 60, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 50, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'Windsor', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 60, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 50, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 40, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'New Western', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 100, ends: 8, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 80, ends: 8, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'Long Western', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 80, ends: 8, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 60, ends: 8, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'Western', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 60, ends: 8, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 50, ends: 8, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'American', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 60, ends: 5, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 50, ends: 5, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 40, ends: 5, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'New National', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 100, ends: 8, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 80, ends: 4, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'Long National', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 80, ends: 8, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 60, ends: 4, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'New Warwick', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 100, ends: 4, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 80, ends: 4, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'Long Warwick', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 80, ends: 4, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 60, ends: 4, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'Warwick', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 60, ends: 4, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 50, ends: 4, arrows_per_end: 6, round: round, target_size: 122)
end