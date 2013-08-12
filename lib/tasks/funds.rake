require Rails.root.join("lib/real_estate_funds_importer")

namespace :real_estate_funds do
  desc "Import funds from Bovespa's site"
  task :import => :environment do
    RealEstateFundsImporter.new.import
  end
end