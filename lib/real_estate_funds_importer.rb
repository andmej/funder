class RealEstateFundsImporter < Mechanize

  def import
    get("http://www.bmfbovespa.com.br/Fundos-Listados/FundosListados.aspx?tipoFundo=imobiliario&Idioma=pt-br")

    # Iterate over each row in the table, except the header
    page.search("table tr")[1..-1].each do |tr|
      razao_social_link = tr.search("td")[0].search("a").first
      nome_de_pregao_link = tr.search("td")[1].search("a").first
      # segmento is column 2. I don't need it.
      # código is column 3. It's an incomplete ticker (FLRP instead of FLRP11B) so I will get it later.
      
      fund = Fund.where(trading_name: nome_de_pregao_link.text,
                        corporate_name: razao_social_link.text).first_or_initialize

      import_fund(fund, razao_social_link)

      fund.save!
    end
  end

  private

  def import_fund(fund, link)
    puts "Processing '#{fund.trading_name}'..."
    # Link points to: 
    # http://www.bmfbovespa.com.br/Fundos-Listados/FundosListadosDetalhe.aspx?Sigla=AEFI&tipoFundo=Imobiliario&aba=abaPrincipal&idioma=pt-br

    get_ticker(fund, link)
    get_documents(fund, link)
  end

  def get_ticker(fund, link)
    transact do
      click link
      # Let's get the ticker(s).
      tickers = page.search(".Dado a")
      fund.ticker = tickers.first.try(:text)

      if tickers.size > 1
        puts "WARNING: '#{fund.trading_name}' has more than one ticker: #{tickers.map(&:text)}"
        puts "         '#{fund.ticker}' will be used."
      end
      puts "    Ticker: #{fund.ticker}"
    end    
  end

  def get_documents(fund, link)
    get_comunicados(fund, link)
  end

  def get_comunicados(fund, link)
    link = link.clone
    # comunicados
    link[:href] = link[:href].gsub("abaPrincipal", "subAbaDocumento") # gsub! doesn't work for some reason.

    transact do
      click link
      (page.search("#tbArqListados tr")[1..-1] || []).each do |tr|

        doc_link = tr.search("td")[0].search("a").first
        title = doc_link.text.strip
        original_url = doc_link[:href].strip
        published_at = Time.zone.parse(tr.search("td")[1].text.strip)

        document = fund.documents.find_by(original_url: original_url) || fund.documents.new(original_url: original_url)
        document.title = title
        document.published_at = published_at
        document.category = "Comunicados"

        puts "    Saving document:"
        print_document(document)

        if document.plain_text.blank?
          begin
            document.convert_to_plain_text
          rescue PDF::Reader::MalformedPDFError => e
            puts "ERROR: PDF #{original_url} is malformed. Exception rescued:"
            puts "       #{e.class}: #{e.message}."
            puts "       Ignoring."
          end
        end

        document.save!
      end
    end
  end

  def print_document(doc)
    doc.attributes.slice("title", "category", "original_url").each do |name, value|
      puts "        #{name}: #{value}"
    end
  end

end