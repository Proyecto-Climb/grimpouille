# frozen_string_literal: true

require 'jsonl_reader_writer'

class JsonlService

  input_filepath = 'db/scraped_data/bronze_routes/bronze_routes_data_skaha.json'

  # pp records = JSON.parse(File.read(input_filepath))['skaha']
  class << self
    def generate_jsonl
      output_filepath = 'db/scraped_data/bronze_routes/bronze_routes_data_skaha.jsonl'
      writer = JsonlReaderWriter::Writer.new(output_filepath)
      data = format_data

      writer.write(data)
    end

    def format_data
      Route.includes(:pitches).map do |route|
        pitch = route.pitches.first
        {
          sector: route.crag.sector.name,
          crag: route.crag.name,
          name: route.name,
          grade: route.grade,
          style: route.style,
          stars: route.stars,
          height: route.height,
          bolts: pitch.bolts,
          url: route.url
        }
      end
    end
  end
end
