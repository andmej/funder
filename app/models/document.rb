require 'open-uri'

class Document < ActiveRecord::Base
  validates_presence_of :title, :original_url
  belongs_to :asset, polymorphic: true

  scope :published_before, ->(date) { where(arel_table[:published_at].lteq(date)) }
  scope :published_after, ->(date) { where(arel_table[:published_at].gteq(date)) }

  def convert_to_plain_text
    raise "Set original_url before calling convert_to_plain_text" if original_url.blank?
    io = open(original_url, "rb")
    reader = PDF::Reader.new(io)
    self.plain_text = reader.pages.map(&:text).join("\n")
  end
end
