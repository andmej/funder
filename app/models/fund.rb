class Fund < ActiveRecord::Base
  validates_presence_of :trading_name
  validates_presence_of :corporate_name
  validates_presence_of :bovespa_url
  has_many :documents, as: :asset, dependent: :destroy
  has_many :dividends, dependent: :destroy

  def to_param
    ticker.presence || id
  end

  # Returns the number of months between the first and last document
  # (both included).
  def months_of_existence
    dates = documents.map(&:published_at).compact # remove nils
    from = dates.min
    to = dates.max
    if from and to
      (to.month + 12 * to.year) - (from.month + 12 * from.year) + 1
    end
  end

  # Returns the number of months that have at least one dividend. If there
  # are two or more dividends in the same month, that month is only counted once.
  def months_with_dividends
    dividends.map { |d| [d.last_day.month, d.last_day.year] }.uniq.size
  end
end
