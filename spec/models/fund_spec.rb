require 'spec_helper'

describe Fund do
  it { should validate_presence_of(:trading_name) }
  it { should validate_presence_of(:corporate_name) }
  it { should validate_presence_of(:bovespa_url) }
  it { should have_many(:documents) }
  it { should have_many(:dividends) }

  context "#months_of_existence" do
    it "calculates how many months its documents cover" do
      f = Fund.new
      f.documents.build(title: "December last year", original_url: "a", published_at: Date.parse("December 31, 2012"))
      f.documents.build(title: "December this year", original_url: "a", published_at: Date.parse("December 1, 2013"))
      expect(f.months_of_existence).to eq 13
    end
  end

  context "#months_with_dividends" do
    it "counts the number of unique months that have dividends" do
      f = Fund.new
      f.dividends.build(amount: 3, last_day: Date.parse("January 3, 2013"))
      f.dividends.build(amount: 5, last_day: Date.parse("January 5, 2013"))
      f.dividends.build(amount: 5, last_day: Date.parse("March 5, 2013"))
      expect(f.months_with_dividends).to eq 2
    end
  end
end
