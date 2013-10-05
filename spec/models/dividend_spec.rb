require 'spec_helper'

describe Dividend do
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:last_day) }
  it { should validate_presence_of(:fund_id) }
  it { should belong_to(:document) }
  it { should belong_to(:fund) }
end
