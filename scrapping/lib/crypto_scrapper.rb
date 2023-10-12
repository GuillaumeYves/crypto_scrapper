require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all"))


names_xpath = '//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--hide-sm cmc-table__cell--sort-by__symbol"]'
prices_xpath= '//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]'

names = page.xpath(names_xpath).map { |element| element.text }
prices = page.xpath(prices_xpath).map { |element| element.text }


crypto_data = names.zip(prices).map { |name, price| { name: name, price: price } }


crypto_data.each do |crypto_hash|
  puts "#{crypto_hash[:name]} => #{crypto_hash[:price]}"
end