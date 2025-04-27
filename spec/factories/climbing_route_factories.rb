# frozen_string_litteral: true

FactoryBot.define do
  PROVINCES = %w(BC Andalucia Catalunya Aragon)
  REGIONS = ['Okanagan Valley', 'El Chorro', 'Siurana']

  factory :country, class: 'Country' do
    name { Faker::Address.country }
    grading_system { 'YDS' }
  end

  factory :province, class: 'Province' do
    name { PROVINCES.sample }
    country
  end

  factory :region, class: 'Region' do
    name { REGIONS.sample }
    province
  end

  factory :sector, class: 'Sector' do
    name { Faker::FunnyName.name }
    region
  end

  factory :crag, class: 'Crag' do
    name { Faker::FunnyName.two_word_name }
    sector
  end

  factory :single_pitch_sport_climbing_route, class: 'ClimbingRoute' do
    name { Faker::Music::RockBand.song }
    grade { GradesConversionService::YDS.keys.sample }
    style { 'sport' }
    stars { rand(0..5) }
    url { Faker::Internet.url }
    height { rand(10..35) }
    crag
  end

  factory :climbing_route, class: 'ClimbingRoute' do

    name { Faker::Music::RockBand.song }
    grade { GradesConversionService::YDS.keys.sample }
    style { 'sport' }
    stars { rand(0..5) }
    url { Faker::Internet.url }
    height { rand(10..35) }

    trait :with_all_associations do
      crag do
        create(
          :crag,
          sector: create(:sector,
          region: create(:region,
          province: create(:province,
          country: create(:country))))
        )
      end
    end
  end
end
