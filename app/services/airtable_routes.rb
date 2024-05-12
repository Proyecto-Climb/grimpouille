# frozen_string_litteral: true

require 'airrecord'

class AirtableRoutes < Airrecord::Table
  self.base_key = 'appCoiCY9TIjMfk2I'
  self.table_name = 'tblzRcP97hKpRTEVG'
  self.api_key = ENV.fetch('AIRTABLE_TOKEN')

  # Routes table
  CRAG_NAME = 'fldgDpD9BxjyAkBBF'
  CRAG_ID = 'fldGUaY46tlOchQNn'
  URL = 'flddGJvbVAUTE1tB6'
  BOLTS = 'fld4Lqy87tc3FKC8K'
  GRADE = 'fld7iqI6ZkVsYCekw'
  STARS = 'fld1cmJYsAkZr7zH1'
  HEIGHT = 'fldsaRjWqBexWce8R'
  STYLE = 'fldPc9LhdkJPmFGqT'

  # DATA_FILE = 'db/scraped_data/bronze_routes/bronze_routes_data_skaha.json'

  # def self.export_to_table
  #   routes_hash = JSON.parse(File.read(DATA_FILE))
  #   sector = routes_hash.keys.first

  #   routes_hash.values.flatten.each do |crags|
  #     crag_name = crags.keys.first
  #     raw_routes_json = crags[crag_name].to_json
  #     create_record(sector, crag_name, raw_routes_json)
  #   end
  # end

  # def self.create_record(:crag_name, :crag_id, :url, :bolts, :grade, :stars, :height, :style)
  #   create(
  #     CRAG_NAME =>
  #     CRAG_ID =>
  #     URL =>
  #     BOLTS =>
  #     GRADE =>
  #     STARS =>
  #     HEIGHT =>
  #     STYLE =>
  #   )
  # end

  def self.extract_routes_data(raw_route_data)
    route_hash = JSON.parse(raw_route_data)
    # pp route_hash
    name = route_hash['name']
    grade = route_hash['gradeAtom']['grade']
    stars = route_hash['stars']&.to_i
    style = route_hash['styleStub']
    height = route_hash['displayHeight']&.first.to_i
    { name: name, grade: grade, stars: stars, style: style, height: height }
  end

  def self.extract_data(raw_data)
    raw_data.map do |data_hash|
      name = data_hash.keys.first
      infos = data_hash[name]
      route_data_hash = extract_routes_data(infos['data'])
      route_data_hash[:url] = "https://www.thecrag.com#{infos['link']}"
      route_data_hash
    end
  end

  def self.fetch_raw_routes
    all_crags = AirtableCrags.all
    all_route_data = all_crags.map do |crag|
      route_data = {}
      route_data[:id] = crag.id
      route_data[:region] = crag.fields['Region']
      route_data[:sector] = crag.fields['Sector']
      route_data[:crag] = crag.fields['Crag']
      route_data[:route_infos] = extract_data(JSON.parse(crag.fields['Raw Routes']))
      route_data
    end
    all_route_data
  end
end
