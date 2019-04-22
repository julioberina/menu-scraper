require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
  url = 'https://postmates.com/merchant/ozen-sushi-buena-park'
  unparsed = HTTParty.get(url)
  parsed = Nokogiri::HTML(unparsed)
  menu_items = parsed.css('div[id^="category-"]')
  popular_item = menu_items.shift
  puts popular_item.css('h2 > div > span').text

  menu_items.each do |item|
    puts item.css('h2').text
  end
end

scraper
