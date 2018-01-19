require 'rails_helper'

RSpec.feature 'Round search', js: true do
  before(:each) do
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
  end

  describe 'text search' do
    it 'takes all search options into account' do
      visit root_path

      fill_in 'search-term', with: 'a'
      expect(page).to have_content('FITA 18')
      expect(page).to have_content('FITA 1440')
      expect(page).not_to have_content('Portsmouth')
      expect(page).to have_content('Albion')

      uncheck('Imperial')
      expect(page).to have_content('FITA 18')
      expect(page).to have_content('FITA 1440')
      expect(page).not_to have_content('Portsmouth')
      expect(page).not_to have_content('Albion')

      uncheck('Indoor')
      expect(page).not_to have_content('FITA 18')
      expect(page).to have_content('FITA 1440')
      expect(page).not_to have_content('Portsmouth')
      expect(page).not_to have_content('Albion')
    end

    it 'filters the list based on the search text' do
      visit root_path

      fill_in 'search-term', with: 'fita'
      expect(page).to have_content('FITA 18')
      expect(page).to have_content('FITA 1440')
      expect(page).not_to have_content('Portsmouth')
      expect(page).not_to have_content('Albion')
    end

    it 'filters the list based on whether it is an imperial or metric round' do
      visit root_path

      uncheck('Metric')
      expect(page).not_to have_content('FITA 18')
      expect(page).not_to have_content('FITA 1440')
      expect(page).to have_content('Portsmouth')
      expect(page).to have_content('Albion')

      uncheck('Imperial')
      expect(page).not_to have_content('FITA 18')
      expect(page).not_to have_content('FITA 1440')
      expect(page).not_to have_content('Portsmouth')
      expect(page).not_to have_content('Albion')

      check('Metric')
      expect(page).to have_content('FITA 18')
      expect(page).to have_content('FITA 1440')
      expect(page).not_to have_content('Portsmouth')
      expect(page).not_to have_content('Albion')
    end

    it 'filters the list based on whether it is an indoor or outdoor round' do
      visit root_path

      uncheck('Outdoor')
      expect(page).to have_content('FITA 18')
      expect(page).not_to have_content('FITA 1440')
      expect(page).to have_content('Portsmouth')
      expect(page).not_to have_content('Albion')

      uncheck('Indoor')
      expect(page).not_to have_content('FITA 18')
      expect(page).not_to have_content('FITA 1440')
      expect(page).not_to have_content('Portsmouth')
      expect(page).not_to have_content('Albion')

      check('Outdoor')
      expect(page).not_to have_content('FITA 18')
      expect(page).to have_content('FITA 1440')
      expect(page).not_to have_content('Portsmouth')
      expect(page).to have_content('Albion')
    end
  end
end
