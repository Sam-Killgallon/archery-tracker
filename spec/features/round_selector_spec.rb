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

      find('a', text: 'FITA 18').click

      # It should have an overview of the selected round
      expect(page).to have_css('h3', text: 'FITA 18 - Metric - Indoor')
      expect(page).to have_css('li', text: 'Distances: 18m')
      expect(page).to have_css('li', text: 'Total arrows: 60')
      expect(page).to have_css('li', text: 'Max score: 600')

      find('a', text: 'Albion').click

      # It should have an overview of the selected round
      expect(page).to have_css('h3', text: 'Albion - Imperial - Outdoor')
      expect(page).to have_css('li', text: 'Distances: 80y, 60y, 50y')
      expect(page).to have_css('li', text: 'Total arrows: 108')
      expect(page).to have_css('li', text: 'Max score: 972')

      # It should have a table displaying detailed info about each distance
      within('.distances-table') do
        expect(page).to have_css('th', text: '80')
        expect(page).to have_css('th', text: '60')
        expect(page).to have_css('th', text: '50')
      end
    end
  end
end
