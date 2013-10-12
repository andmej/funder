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
      compare("01.txt", nil, {amount: 0.62829442, last_day: Date.parse("September 30, 2013")})
      compare("02.txt", nil, {amount: 0.75, last_day: Date.parse("September 23, 2013")})
      compare("03.txt", nil, {amount: 0.720732334, last_day: Date.parse("May 31, 2013")})
      compare("04.txt", nil, {amount: 0.44999497, last_day: Date.parse("August 30, 2013")})
      compare("05.txt", nil, {amount: 6.760977725, last_day: Date.parse("September 30, 2013")})
      compare("06.txt", nil, {amount: 13.50, last_day: Date.parse("December 28, 2012")})
      compare("07.txt", nil, {amount: 8.80, last_day: Date.parse("December 30, 2009")})
      compare("08.txt", nil, {amount: 5.50, last_day: Date.parse("September 30, 2013")})
      compare("09.txt", nil, {amount: 30.13959246154, last_day: Date.parse("September 30, 2013")})
      compare("10.txt", nil, {amount: 12.50, last_day: Date.parse("January 31, 2012")})
      compare("11.txt", nil, {amount: 1.00352859, last_day: Date.parse("September 19, 2013")})
      compare("12.txt", nil, {amount: 118.99688715, last_day: Date.parse("July 25, 2013")})
      compare("13.txt", nil, {amount: 1.0253115, last_day: Date.parse("September 30, 2013")})
      compare("14.txt", nil, {amount: 0.985146128, last_day: Date.parse("September 6, 2013")})
      compare("15.txt", nil, {amount: 8.96, last_day: Date.parse("June 12, 2013")})
      compare("16.txt", nil, {amount: 0.84531729, last_day: Date.parse("June 7, 2013")})
      compare("17.txt", nil, {amount: 0.934971374, last_day: Date.parse("September 6, 2013")})
      compare("18.txt", nil, {amount: 0.19, last_day: Date.parse("May 1, 2013")})
      compare("19.txt", nil, {amount: 1.02314066038, last_day: Date.parse("January 1, 2013")})
      compare("20.txt", nil, {amount: 0.48160925876, last_day: Date.parse("August 31, 2012")})
    end
  end
end
