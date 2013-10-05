require 'spec_helper'
require Rails.root.join 'lib/dividend_report_parser'

describe DividendReportParser do
  context "#parse" do
    def compare(fixture_name, title, expected_hash)
      fixture_file = Rails.root.join "spec/lib/fixtures", fixture_name
      parser = DividendReportParser.new(title, File.read(fixture_file))
      expect(parser.parse).to eq(expected_hash)
    end

    it "extracts the correct values" do
      compare("1.txt", nil, {amount: 0.62829442, last_day: Date.parse("September 30, 2013")})
    end
  end
end

