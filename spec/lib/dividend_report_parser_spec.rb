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
      compare("2.txt", nil, {amount: 0.75, last_day: Date.parse("September 23, 2013")})
      compare("3.txt", nil, {amount: 0.720732334, last_day: Date.parse("May 31, 2013")})
      compare("4.txt", nil, {amount: 0.44999497, last_day: Date.parse("August 30, 2013")})
      compare("5.txt", nil, {amount: 6.760977725, last_day: Date.parse("September 30, 2013")})
      compare("6.txt", nil, {amount: 13.50, last_day: Date.parse("December 28, 2012")})
      compare("7.txt", nil, {amount: 8.80, last_day: Date.parse("December 30, 2009")})
      compare("8.txt", nil, {amount: 5.50, last_day: Date.parse("September 30, 2013")})
      compare("9.txt", nil, {amount: 30.13959246154, last_day: Date.parse("September 30, 2013")})
      compare("10.txt", nil, {amount: 12.50, last_day: Date.parse("January 31, 2012")})
      compare("11.txt", nil, {amount: 1.00352859, last_day: Date.parse("September 19, 2013")})
      compare("12.txt", nil, {amount: 118.99688715, last_day: Date.parse("July 25, 2013")})

    end
  end
end
