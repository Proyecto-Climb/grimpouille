# frozen_string_literal: true

def seed_spain(ines, steph)
  puts 'Creating Spain country'
  spain = Country.create!(name: 'Spain', grading_system: 'EU')

  puts 'Creating Catalunya province'
  catalunya = Province.create!(name: 'Catalunya', country: spain)

  puts 'Creating Tarragona region'
  tarragona = Region.create!(name: 'Tarragona', province: catalunya)

  puts 'Creating Siurana sector'
  siurana = Sector.create!(name: 'Siurana', region: tarragona)

  puts 'Creating Herbolari crag'
  herbolari = Crag.create!(name: "L'Herbolari", sector: siurana)

  puts 'Creating Brain Storming route'
  brain_storming = ClimbingRoute.create!(
    name: 'Brain Storming',
    grade: '6b',
    style: 1,
    crag: herbolari
  )

  # brain_storming_pitch = Pitch.create!(
  #   length: 22,
  #   position: 1,
  #   pitch_grade: '6b',
  #   bolts: 8,
  #   angle: 2,
  #   climbing_route: brain_storming
  # )

  puts 'Creating Brain Storming climb for Ines'
  brain_storming_ines = Climb.create!(climber: ines, climbing_route: brain_storming, status: 4) #, attempts: 2)
  puts 'Creating Brain Storming climb for Steph'
  brain_storming_steph = Climb.create!(climber: steph, climbing_route: brain_storming, status: 3) #, attempts: 2)

  attempt_date_day1 = DateTime.new(2024, 03, 26)
  attempt_date_day2 = DateTime.new(2024, 03, 27)

  brain_storming_ines_attempt1 = Attempt.create!(date: attempt_date_day1, notes: 'Pioupioupiou', status: 4, climb: brain_storming_ines)
  brain_storming_ines_attempt2 = Attempt.create!(date: attempt_date_day2, notes: 'Siempre pioupioupiou', status: 4, climb: brain_storming_ines)

  brain_storming_steph_attempt1 = Attempt.create!(date: attempt_date_day1, notes: 'Wouaahhhh', status: 4, climb: brain_storming_steph)
  brain_storming_steph_attempt2 = Attempt.create!(date: attempt_date_day2, notes: 'Wouhou!', status: 3, climb: brain_storming_steph)
end
