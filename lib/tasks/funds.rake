require Rails.root.join("lib/dividend_report_parser")
require Rails.root.join("lib/real_estate_funds_importer")

namespace :real_estate_funds do
  desc "Import funds from Bovespa's site"
  task :import => :environment do
    RealEstateFundsImporter.new.import
  end

  desc "Parse dividends from documents downloaded from Bovespa's site"
  task :parse_dividends => :environment do
    DividendReportParser.parse_existing_documents
  end
end
