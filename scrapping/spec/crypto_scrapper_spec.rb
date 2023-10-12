require_relative 'scrapping/lib/crypto_scrapper'

describe 'CryptoScraper' do
  it 'scrapes cryptocurrency names and prices' do
    page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all"))

    names_xpath = '//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--hide-sm cmc-table__cell--sort-by__symbol"]'
    prices_xpath = '//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]'

    names = page.xpath(names_xpath).map { |element| element.text }
    prices = page.xpath(prices_xpath).map { |element| element.text }

    crypto_data = names.zip(prices).map { |name, price| { name: name, price: price } }

    expect(names).to be_a(Array)
    expect(prices).to be_a(Array)
    expect(crypto_data).to be_a(Array)

    crypto_data.each do |crypto_hash|
      expect(crypto_hash[:name]).to be_a(String)
      expect(crypto_hash[:price]).to be_a(String)
    end
  end
end