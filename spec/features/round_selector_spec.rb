require 'rails_helper'

RSpec.feature 'Round selector', js: true do
  describe 'round list' do
    it 'displays a list of all rounds and shows details when one is clicked' do
      Round.create!(name: 'Portsmouth', indoor: true, metric: false).tap do |round|
        RoundDistance.create!(distance: 20, ends: 20, arrows_per_end: 3, round: round)
      end

      Round.create!(name: 'FITA 18', indoor: true, metric: true).tap do |round|
        RoundDistance.create!(distance: 18, ends: 20, arrows_per_end: 3, round: round)
      end

      Round.create!(name: 'FITA 1440', indoor: false, metric: true).tap do |round|
        RoundDistance.create!(distance: 90, ends: 6, arrows_per_end: 6, round: round)
        RoundDistance.create!(distance: 70, ends: 6, arrows_per_end: 6, round: round)
        RoundDistance.create!(distance: 50, ends: 12, arrows_per_end: 3, round: round)
        RoundDistance.create!(distance: 30, ends: 12, arrows_per_end: 3, round: round)
      end

      Round.create!(name: 'Albion', indoor: false, metric: false).tap do |round|
        RoundDistance.create!(distance: 80, ends: 6, arrows_per_end: 6, round: round)
        RoundDistance.create!(distance: 60, ends: 6, arrows_per_end: 6, round: round)
        RoundDistance.create!(distance: 50, ends: 6, arrows_per_end: 6, round: round)
      end

      visit root_path 
      # Should have a list with all the rounds
      expect(page).to have_content('Portsmouth')
      expect(page).to have_content('FITA 18')
      expect(page).to have_content('FITA 1440')
      expect(page).to have_content('Albion')

      click_on 'Albion'

      expect(page).to have_content('Albion - Imperial - Outdoor')
      expect(page).to have_content('Distances: 80, 60, 50')
      expect(page).to have_content('Total arrows: 108')
      expect(page).to have_content('Max score: 1080')
    end
  end
end
