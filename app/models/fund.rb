class Fund < ActiveRecord::Base
  validates_presence_of :trading_name
  validates_presence_of :corporate_name
  validates_presence_of :bovespa_url
  has_many :documents, as: :asset, dependent: :destroy

  def to_param
    ticker.presence || id
  end
end
