require 'round_pdf_generator'
require 'pdf/inspector'
require 'prawn/table'

RSpec.describe RoundPdfGenerator do
  let(:instance) { described_class.new(round) }
  let(:round) { double(:round, name: round_name, total_arrows: total_arrows) }
  let(:round_name) { 'My Awesome Round' }
  let(:total_arrows) { 60 }

  describe '#render' do
    subject { instance.render }
    let(:pdf_page) { PDF::Inspector::Page.analyze(subject) }
    let(:pdf_text) { PDF::Inspector::Text.analyze(subject) }

    it 'contains the round name' do
      expect(pdf_text.strings).to include(round_name)
    end

    it 'contains a field for the archers name' do
      expect(pdf_text.strings).to include(/Name:\s+_+/)
    end

    it 'contains a field for the club name' do
      expect(pdf_text.strings).to include(/Club:\s+_+/)
    end

    it 'contains a field for the date' do
      expect(pdf_text.strings).to include(/Date:\s+_+/)
    end

    it 'contains the website address' do
      expect(pdf_text.strings).to include('https://archery-tracker.co.uk')
    end

    context 'with the maximum number of arrows in a round' do
      let(:total_arrows) { 144 }

      it 'fits on one page' do
        expect(pdf_page.pages.size).to be 1
      end
    end

    # Fragile tests to ensure the table is correct, as once the table has been
    # added to the document, we can't get a reference on it
    context 'the rounds table' do
      # Accessing a private method :(
      let(:table) { instance.send(:draw_table, Prawn::Document.new) }

      # If this breaks its probably because we have refactored the private method in some way
      it 'draws a table' do
        expect(instance).to receive(:draw_table)
        subject
      end

      it 'has a row for each dozen' do
        # One row for each 12, plus the headers and the final count
        expect(table.row_length).to be(5 + 2)
      end

      it 'has the correct number of columns' do
        # Each 'score' entry section represents 3 columns
        expect(table.column_length).to be(17)
      end

      it 'has the correct headers' do
        # Strip the empty nils which are just used for padding
        headers = table.row(0).map(&:content).compact
        expect(headers).to eql([
          'Score',
          'End',
          'Score',
          'Total',
          'Hits',
          'Golds',
          'Xs'
        ])
      end

      it 'has empty cells for all rows except the header' do
        cells = table.rows(1..-1).map(&:content)
        expect(cells).to satisfy do |cells|
          # Ensure all cells are blank or nil, ie empty
          cells.all? { |cell| cell.nil? || cell == '' }
        end
      end

      it 'only shows cells for totals on the final row' do
        totals = table.row(-1).map(&:content)
        # A cell which spans multiple columns will have an empty string for
        # where it begins, followed by nils to represent the extra cells it
        # takes up. So we expect a single large empty cell, then 4 actual cells
        expect(totals).to eql([
          '',
          *Array.new(12, nil),
          '',
          '',
          '',
          ''
        ])
      end

      # Support for rounds that end on half dozens
      context 'when the total number of arrows is not divisable by 12' do
        let(:total_arrows) { 30 }

        it 'has a row for the final half dozen' do
          # 2 Full rows + a half final row
          scoring_rows = 3
          expect(table.row_length).to be(scoring_rows + 2)
        end

        it 'has a partial final scoring row' do
          totals = table.row(-2).map(&:content)
          expect(totals).to eql([
            '', nil, nil,
            '', nil, nil,
            '',
            '',
            *Array.new(5, nil),
            '',
            '',
            '',
            ''
          ])
        end
      end
    end
  end
end
