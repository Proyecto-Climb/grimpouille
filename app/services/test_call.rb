# frozen_string_litteral: true

require 'open-uri'
require 'nokogiri'

def fetch_nokogiri_doc(url)
  html = URI.open(url).read
  Nokogiri::HTML.parse(html)
end

def fetch_areas_links(html_doc)
  areas = '.lef-nav-row'

  main_html_doc.search(areas).map do |element|
    link = element.children[1].attribute('href').value
    # name = element.children[1].text.match(/(\(.+\)) (?<name>.+)/)[:name].strip
    # { name => link }
  end
end

def scrape_area(link)
  html_doc = fetch_nokogiri_doc(link)

  areas = '.lef-nav-row'

  main_html_doc.search(areas).map do |element|
    link = element.children[1].attribute('href').value
    # name = element.children[1].text.match(/(\(.+\)) (?<name>.+)/)[:name].strip
    # { name => link }
  end
end

url = 'https://www.mountainproject.com/area/105946462/skaha'

html_doc = fetch_nokogiri_doc(url)
areas_links = fetch_areas_links(html_doc)

pp areas_data = area_links.first(1).map { |link| scrape_area(link) }
