# # frozen_string_litteral: true

# require 'open-uri'
# require 'nokogiri'
# require 'json'

# def fetch_nokogiri_doc(url)
#   html = URI.open(url).read
#   Nokogiri::HTML.parse(html)
# end

# def scrape(link, _selector)
#   html_doc = fetch_nokogiri_doc(link)

#   html_doc.search(areas).map do |element|
#     name = element.children.text.strip
#     link = element.children.attribute('href').value
#     { name => link }
#   end
# end

# base_url = 'https://www.thecrag.com/'
# filepath = 'db/scraped_data/skaha_bronze.json'
# selector = 'div.route'
# sector_urls = JSON.parse(File.read(filepath))

# # routes = sector_urls.first(1).each_with_object({}) do |link_hash, result_hash|
# #                                 area_name = link_hash.keys.first
# #                                 area_links = scrape(base_url + link_hash.values.first, selector)
# #                                 result_hash[area_name] = area_links
# #                               end

# # url = 'https://www.thecrag.com/en/climbing/canada/skaha'
# # selector = '.selected.open-submenu > ul li'
# # areas_links = scrape(url, selector)

# # File.open('db/scraped_data/skaha_bronze.json', "wb") do |file|
# #   file.write(JSON.pretty_generate(areas_links))
# # end

# # sector_data = areas_links.each_with_object({}) do |link_hash, result_hash|
# #                 area_name = link_hash.keys.first
# #                 area_links = scrape(link_hash.values.first)
# #                 result_hash[area_name] = area_links
# #               end
require 'open-uri'
require 'nokogiri'
require 'json'

require 'net/http'
require 'uri'

def fetch_nokogiri_doc(url)
  # html = URI.open(url).read
  # Nokogiri::HTML.parse(html)

  uri = URI(url)
  request = Net::HTTP::Get.new(uri)
  request['User-Agent'] = "Ruby/#{RUBY_VERSION}"

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(request)
  end

  Nokogiri::HTML.parse(response.body)
end

def scrape(link, selector)
  html_doc = fetch_nokogiri_doc(link)

  html_doc.search(selector).map do |element|
    pp element
    # name = element.children.text.strip
    # link = element.children.attribute('href').value
    # { name => link }
  end
end

# base_url = 'https://www.thecrag.com/'
# filepath = 'db/scraped_data/siurana_bronze.json'
# selector = 'div.route'
# sector_urls = JSON.parse(File.read(filepath))

# routes = sector_urls.first(1).each_with_object({}) do |link_hash, result_hash|
#                                 area_name = link_hash.keys.first
#                                 area_links = scrape(base_url + link_hash.values.first, selector)
#                                 result_hash[area_name] = area_links
#                               end

url = 'https://www.thecrag.com/en/climbing/spain/siurana'
selector = '.selected.open-submenu > ul li'
areas_links = scrape(url, selector)

File.open('db/scraped_data/bronze_data/siurana_bronze.json', "wb") do |file|
  file.write(JSON.pretty_generate(areas_links))
end

# sector_data = areas_links.each_with_object({}) do |link_hash, result_hash|
#                 area_name = link_hash.keys.first
#                 area_links = scrape(link_hash.values.first)
#                 result_hash[area_name] = area_links
#               end
# sector_data
