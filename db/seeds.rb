# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Round.destroy_all

Round.create!(name: 'Portsmouth', indoor: true, metric: false).tap do |round|
  RoundDistance.create!(distance: 20, ends: 20, arrows_per_end: 3, round: round, target_size: 60)
end

Round.create!(name: 'FITA 18', indoor: true, metric: true).tap do |round|
  RoundDistance.create!(distance: 18, ends: 20, arrows_per_end: 3, round: round, target_size: 40)
end

Round.create!(name: 'FITA 25', indoor: true, metric: true).tap do |round|
  RoundDistance.create!(distance: 25, ends: 20, arrows_per_end: 3, round: round, target_size: 60)
end

Round.create!(name: 'Vegas', indoor: true, metric: false).tap do |round|
  RoundDistance.create!(distance: 18, ends: 20, arrows_per_end: 3, round: round, target_size: 40)
end

Round.create!(name: 'Worcester', indoor: true, metric: false).tap do |round|
  RoundDistance.create!(distance: 20, ends: 12, arrows_per_end: 5, round: round, target_size: 40.6)
end

Round.create!(name: 'FITA 1440', indoor: false, metric: true).tap do |round|
  RoundDistance.create!(distance: 90, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 70, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 50, ends: 12, arrows_per_end: 3, round: round, target_size: 80)
  RoundDistance.create!(distance: 30, ends: 12, arrows_per_end: 3, round: round, target_size: 80)
end

Round.create!(name: 'Albion', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 80, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 60, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 50, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
end

Round.create!(name: 'York', indoor: false, metric: false).tap do |round|
  RoundDistance.create!(distance: 100, ends: 6, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 80, ends: 4, arrows_per_end: 6, round: round, target_size: 122)
  RoundDistance.create!(distance: 60, ends: 2, arrows_per_end: 6, round: round, target_size: 122)
end
