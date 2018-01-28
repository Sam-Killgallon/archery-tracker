class RoundPdfGenerator
  def self.storage_path
    'public/system/score_sheets'.freeze
  end

  def initialize(round)
    @round = round
  end

  def save
    file_path = File.join(self.class.storage_path, filename)
    Prawn::Document.generate(file_path, page_layout: :landscape, size: 'A4') do |pdf|
      pdf.table(score_table, width: pdf.bounds.width, cell_style: { height: 30 }) do |t|
        t.before_rendering_page do |page|
          # Outline the mid end total boxes
          page.column(6).border_top_width = 2
          page.column(6).border_bottom_width = 2
          page.column(6).border_left_width = 2
          page.column(6).border_right_width = 2

          # Outline the total boxes on the right of the page
          page.column(13).border_left_width = 2
          page.column(16).border_right_width = 2
          page.row(0).column(13).border_top_width = 2
          page.row(0).column(14).border_top_width = 2
          page.row(0).column(15).border_top_width = 2
          page.row(0).column(16).border_top_width = 2
          page.row(-1).column(13).border_bottom_width = 2
          page.row(-1).column(14).border_bottom_width = 2
          page.row(-1).column(15).border_bottom_width = 2
          page.row(-1).column(16).border_bottom_width = 2
        end
      end
    end
  end

  private

  attr_reader :round

  def filename
    "#{round.name}.pdf"
  end

  def score_table
    table = [headers]
    # Each row contains a dozen arrows
    no_of_rows = round.total_arrows / 12
    no_of_rows.times do
      # TODO: Handle rounds that end on a half dozen, `divmod` should help here
      table << [*half_dozen, '', *half_dozen, *totals_columns]
    end

    table << [{ content: '', colspan: 13, borders: [] }, *totals_columns]
    table
  end

  def totals_columns
    ['', '', '', '']
  end

  def half_dozen
    no_of_cells = 2
    Array.new(no_of_cells) { {content: '', colspan: (6 / no_of_cells) } }
  end

  def headers
    [
      header(content: 'Score', colspan: 6),
      header(content: 'End'),
      header(content: 'Score', colspan: 6),
      header(content: 'Total'),
      header(content: 'Hits'),
      header(content: 'Golds'),
      header(content: 'Xs')
    ]
  end

  def header(options)
    { align: :center }.merge(options)
  end
end

=begin
   score    | end total |    score    | line total | hits | golds | x's
1,2,3,4,5,6 |           | 1,2,3,4,5,6 |            |      |       |
=end
