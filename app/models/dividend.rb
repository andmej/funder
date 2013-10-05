class Dividend < ActiveRecord::Base
  belongs_to :document
  belongs_to :fund

  validates_presence_of :amount
  validates_presence_of :last_day
  validates_presence_of :fund_id

  scope :last_day_before, ->(date) { where(arel_table[:last_day].lteq(date)) }
  scope :last_day_after, ->(date) { where(arel_table[:last_day].gteq(date)) }
end
