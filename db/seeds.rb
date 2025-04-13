# frozen_string_litteral: true

require_relative 'seeds/spain_seed'

unless Rails.env.production?
  Attempt.destroy_all
  Climb.destroy_all
  User.destroy_all
  Pitch.destroy_all
  ClimbingRoute.destroy_all
  Crag.destroy_all
  Sector.destroy_all
  Region.destroy_all
  Province.destroy_all
  Country.destroy_all
end

puts 'Creating climbers...'
ines = User.create!(first_name: 'Ines', last_name: 'Alvergne', email: 'i@i.i', password: 111111, admin: true, developer: true)
steph = User.create!(first_name: 'Stephane', last_name: 'Lafontaine', email: 's@s.s', password: 111111, admin: true, developer: true)

# Running the Spain seed
seed_spain(ines, steph)

puts 'Creating Canada country'
canada = Country.create!(name: 'Canada', grading_system: 'YDS')

puts 'Creating British Columbia province'
bc = Province.create!(name: 'British Columbia', country: canada)

puts 'Creating okanagan_valley region'
okanagan_valley = Region.create!(name: 'Okanagan Valley', province: bc)

puts 'Creating skaha sector'
skaha = Sector.create!(name: 'Skaha', region: okanagan_valley)

uniqs_crag_records = AirtableSeed.all.uniq { |record| record['Crag'] }

uniqs_crag_records.each do |record|
  puts "Creating #{record['Crag']} crag"
  Crag.create!(name: record['Crag'], sector: skaha)
end

AirtableSeed.all.each do |route_data|
  ActiveRecord::Base.transaction do
    puts "Creating #{route_data['Route name']} route"
    climbing_route = ClimbingRoute.create!(
      name: route_data['Route name'],
      grade: route_data['Grade'],
      style: AirtableSeed.format_style(route_data['Style']),
      crag: Crag.find_by_name(route_data['Crag']),
      stars: route_data['Stars'],
      url: route_data['URL'],
      height: route_data['Height']
      )

    pitch = Pitch.new(
      position: 1,
      length: climbing_route.height,
      pitch_grade: climbing_route.grade,
      angle: 90,
      bolts: route_data['Bolts']
    )

    pitch.climbing_route = climbing_route
    pitch.save!
  end
end
