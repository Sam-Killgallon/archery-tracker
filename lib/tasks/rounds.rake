namespace :rounds do
  desc 'Create PDFs for all rounds'

  task pdf: :environment do
    FileUtils.mkdir('score_sheets') unless File.exist?('score_sheets')

    Round.all.each do |round|
      puts "Generating pdf for #{round.name}"
      RoundPdfGenerator.new(round).save
    end
  end
end
