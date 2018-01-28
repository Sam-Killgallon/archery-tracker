namespace :rounds do
  desc 'Create PDFs for all rounds'

  task pdf: :environment do
    storage_path = RoundPdfGenerator.storage_path
    FileUtils.mkdir_p(storage_path) unless File.exist?(storage_path)

    Round.all.each do |round|
      puts "Generating pdf for #{round.name}"
      RoundPdfGenerator.new(round).save
    end
  end
end
