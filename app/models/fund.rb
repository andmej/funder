class Fund < ActiveRecord::Base
  validates_presence_of :trading_name
  validates_presence_of :corporate_name
end
