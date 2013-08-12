class Document < ActiveRecord::Base
  validates_presence_of :title, :original_url
  belongs_to :asset, polymorphic: true

  scope :published_before, ->(date) { where(arel_table[:published_at].lteq(date)) }
  scope :published_after, ->(date) { where(arel_table[:published_at].gteq(date)) }
end
