# encoding: utf-8

class DividendReportParser
  attr_accessor :title, :content

  def initialize(title, content)
    @title = title
    @content = content.gsub(/\s+/m, " ") # Leave a single space between tokens.
  end

  # Returns a hash with everything that could be extracted.
  # Possible keys are:
  #  - amount: (Float) the amount that was distributed.
  #  - last_day: (Date) the last day on which you are eligible to receive this
  #     dividends.
  def parse
    answer = {}
    answer[:amount] = get_amount
    answer[:last_day] = get_last_day
    answer.select { |k, v| v }
  end

  private

  def get_amount
    if @content =~ /no valor de R\$ ([0-9,\.]+) por cota/
      return parse_number($1)
    end
  end

  def get_last_day
    if @content =~ /com base na posição de cotistas de ([0-9]+\/[0-9]+\/[0-9]+)/
      return parse_date($1)
    end
  end

  def parse_number(text)
    text.gsub(",", ".").strip.to_f
  end

  def parse_date(text)
    Date.parse(text.strip)
  end
end
