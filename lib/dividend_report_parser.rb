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

  # Parses and creates dividends from the documents in the DB.
  def self.parse_existing_documents
    Document.includes(:dividend).each do |doc|
      if doc.plain_text.present? and doc.dividend.blank?
        fields = DividendReportParser.new(doc.title, doc.plain_text).parse
        dividend = Dividend.new(document: doc, fund: doc.asset, amount: fields[:amount], last_day: fields[:last_day])
        if dividend.save
          puts "Doc #{doc.id}: Saved dividend for #{dividend.amount} on #{dividend.last_day} for #{dividend.fund.ticker}."
        else
          puts "Doc #{doc.id}: Failed to save dividend with attributes #{dividend.attributes.inspect}."
        end
      end
    end
  end

  private

  def get_amount
    if @content =~ /no valor de R\$\s?([0-9,\.]+) por cota/
      return parse_number $1
    end
    if @content =~ /no valor de R\$ R\$ ([0-9,\.]+) por cota/ # WTF. Stupid bankers.
      return parse_number $1
    end
    if @content =~ /no valor de R\$\s?([0-9,\.]+)\s?\/\s?cota/
      return parse_number $1
    end
    if @content =~ /no valor bruto de R\$\s?([0-9,\.]+) por cota/
      return parse_number $1
    end
    if @content =~ /Valor do rendimento por cota: R\$\s?([0-9,\.]+)/i
      return parse_number $1
    end
    if @content =~ /Valor do rendimento: R\$\s?([0-9,\.]+)/i
      return parse_number $1
    end
    if @content =~ /corresponde a R\$\s?([0-9,\.]+) por cota/
      return parse_number $1
    end
    if @content =~ /é de R\$\s?([0-9,\.]+) por cota/
      return parse_number $1
    end
    if @content =~ /foi de R\$\s?([0-9,\.]+) por cota/
      return parse_number $1
    end
    if @content =~ /Valor distribuído por cota: R\$\s?([0-9,\.]+)/
      return parse_number $1
    end
    if @content =~ /Valor bruto distribuído por cota: R\$\s?([0-9,\.]+)/
      return parse_number $1
    end
    if @content =~ /corresponde a R\$\s?([0-9,\.]+) \([^0-9]+ reais e [^0-9]+ centavos\) por quota/
      return parse_number $1
    end
    if @content =~ /valor do rendimento equivale a R\$\s?([0-9,\.]+) por cota/
      return parse_number $1
    end
    if @content =~ /Valor bruto do rendimento[^\.]*: R\$\s?([0-9,\.]+)/i
      return parse_number $1
    end
  end

  def get_last_day
    if @content =~ /com base na posição de cotistas de ([0-9]+\/[0-9]+\/[0-9]+)/
      return parse_date $1
    end
    if @content =~ /aos titulares de cotas em ([0-9]+\/[0-9]+\/[0-9]+)/
      return parse_date $1
    end
    if @content =~ /aos cotistas com posição até ([0-9]+\/[0-9]+\/[0-9]+)/
      return parse_date $1
    end
    if @content =~ /aos detentores de cotas em ([0-9]+\/[0-9]+\/[0-9]+)/
      return parse_date $1
    end
    if @content =~ /- Data base: ([0-9]+\/[0-9]+\/[0-9]+)/
      return parse_date $1
    end
    if @content =~ /- Data-base: ([0-9]+\/[0-9]+\/[0-9]+)/
      return parse_date $1
    end
    if @content =~ /Data Base: ([0-9]+\/[0-9]+\/[0-9]+)/
      return parse_date $1
    end
    if @content =~ /A partir de ([0-9]+\/[0-9]+\/[0-9]+),? cotas ex-rendimento/i
      return previous_business_day parse_date $1
    end
    if @content =~ /Desde ([0-9]+\/[0-9]+\/[0-9]+),? cotas ex-rendimento/i
      return previous_business_day parse_date $1
    end
  end

  def parse_number(text)
    text.gsub(",", ".").strip.to_f
  end

  def parse_date(text)
    Date.parse(text.strip)
  end

  def previous_business_day(date)
    date = date - 1.day
    while [0, 6].include? date.wday
      date = date - 1.day
    end
    date
  end
end
