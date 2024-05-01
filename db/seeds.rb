unless Rails.env.production?
  Climb.destroy_all
  User.destroy_all
  Route.destroy_all
  Crag.destroy_all
  Sector.destroy_all
  Region.destroy_all
end

ines = User.create!(first_name: 'Ines', last_name: 'Alvergne', email: 'i@i.i', password: 111111)
steph = User.create!(first_name: 'Stephane', last_name: 'Lafontaine', email: 's@s.s', password: 111111)

catalunya = Region.create!(name: 'Catalunya')
siurana = Sector.create!(name: 'Siurana', region: catalunya)
herbolari = Crag.create!(name: "L'Herbolari", sector: siurana)
brain_storming = Route.create!(
  name: 'Brain Storming',
  grade: '6b',
  length: 22,
  style: 1,
  angle: 2,
  bolts: 8,
  crag: herbolari
)

brain_storming_ines = Climb.create!(climber: ines, route: brain_storming, status: 4, attempts: 2)
brain_storming_steph = Climb.create!(climber: steph, route: brain_storming, status: 3, attempts: 2)
