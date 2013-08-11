namespace :real_estate_funds do
  desc "Import funds from Bovespa's site"
  task :import => :environment do
    RealEstateFundsImporter.new.import
  end
end