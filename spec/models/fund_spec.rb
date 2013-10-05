require 'spec_helper'

describe Fund do
  it { should validate_presence_of(:trading_name) }
  it { should validate_presence_of(:corporate_name) }
  it { should validate_presence_of(:bovespa_url) }
  it { should have_many(:documents) }
end
