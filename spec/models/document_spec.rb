require 'spec_helper'

describe Document do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:original_url) }
end
