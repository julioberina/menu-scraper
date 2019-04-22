require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
  url = 'https://postmates.com/merchant/ozen-sushi-buena-park'
  unparsed = HTTParty.get(url)
  parsed = Nokogiri::HTML(unparsed)
  menu_items = parsed.css('div[id^="category-"]')
  byebug
end

scraper
