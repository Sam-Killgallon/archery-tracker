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

  def render
    pdf.render
  end

  private

  attr_reader :round

  def pdf
    return @pdf if defined?(@pdf)
    @pdf = Prawn::Document.new(page_layout: :portrait, size: 'A4').tap do |document|
      draw_headers(document)
      draw_table(document)
      draw_footer(document)
    end
  end

  def draw_headers(document)
    document.bounding_box([0, document.bounds.top], width: document.bounds.width - 200) do
      document.font_size(25) { document.text round.name, align: :center }
    end

    document.bounding_box([document.bounds.width - 200, document.bounds.top], width: 200) do
      document.text 'Name: _______________________', leading: 8
      document.text 'Club:   _______________________', leading: 8
      document.text 'Date:   _______________________', leading: 8
    end
  end

  def draw_table(document)
    document.table(score_table, width: document.bounds.width, cell_style: { height: 30 }) do |t|
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
  end

  def draw_footer(document)
    document.transparent(0.5) do
      document.text_box 'https://archery-tracker.co.uk', at: document.bounds.absolute_bottom_left
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
      table << [*half_dozen, nil, *half_dozen, *totals_columns]
    end

    table << [{ content: nil, colspan: 13, borders: [] }, *totals_columns]
    table
  end

  def totals_columns
    Array.new(4, nil)
  end

  def half_dozen
    no_of_cells = 2
    # Array.new(no_of_cells) { {content: nil, colspan: (6 / no_of_cells) } }
    Array.new(no_of_cells, content: nil, colspan: (6 / no_of_cells))
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
