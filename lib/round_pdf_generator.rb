class RoundPdfGenerator
  def self.storage_path
    'public/system/score_sheets'.freeze
  end

  def initialize(round)
    @round = round
  end

  def save
    file_path = File.join(self.class.storage_path, filename)
    pdf.render_file(file_path)
  end

  private

  attr_reader :round

  def pdf
    Prawn::Document.new(page_layout: :portrait, size: 'A4').tap do |pdf|
      pdf.bounding_box([0, pdf.bounds.top], width: pdf.bounds.width - 200) do
        pdf.font_size(25) { pdf.text round.name, align: :center }
      end

      pdf.bounding_box([pdf.bounds.width - 200, pdf.bounds.top], width: 200) do
        pdf.text 'Name: _______________________', leading: 8
        pdf.text 'Club:   _______________________', leading: 8
        pdf.text 'Date:   _______________________', leading: 8
      end

      pdf.table(score_table, width: pdf.bounds.width, cell_style: { height: 30 }) do |t|
        border_width = 2

        # Outline the halfway total box
        t.column(6).tap do |col|
          col.border_top_width    = border_width
          col.border_bottom_width = border_width
          col.border_left_width   = border_width
          col.border_right_width  = border_width
        end

        # Outline the total boxes on the right of the table
        t.column(13).border_left_width               = border_width
        t.column(16).border_right_width              = border_width
        t.row(0).column(13..16).border_top_width     = border_width
        t.row(-1).column(13..16).border_bottom_width = border_width
      end

      pdf.transparent(0.5) do
        pdf.text_box 'https://archery-tracker.co.uk', at: pdf.bounds.absolute_bottom_left
      end
    end
  end

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
