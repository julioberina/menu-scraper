require 'nokogiri'
require 'httparty'
require 'byebug'
require 'json'

def scraper
  url = 'https://postmates.com/merchant/ozen-sushi-buena-park'
  unparsed = HTTParty.get(url)
  parsed = Nokogiri::HTML(unparsed)
  data = {}
  menu_categories = parsed.css('div[id^="category-"]')
  popular_items = menu_categories.shift
  popular_items_data = []
  popular_items.css('div > div.product-container').each do |item|
    food = {}
    food['name'] = item.css('h3.product-name').text || ''
    food['description'] = item.css('div.product-description').text || ''
    food['price'] = item.css('div > div > span').text || ''
    popular_items_data << food
  end

  data[popular_items.css('h2 > div > span').text] = popular_items_data

  menu_categories.each do |category|
    menu_items = []

    category.css('div > div.product-container').each do |item|
      food = {}
      food['name'] = item.css('h3.product-name').text || ''
      food['description'] = item.css('div.product-description').text || ''
      food['price'] = item.css('div > div > span').text || ''
      menu_items << food
    end

    data[category.css('h2').text] = menu_items
  end

  File.open("menu.json", "w") { |file| file.write data.to_json }
end

scraper
