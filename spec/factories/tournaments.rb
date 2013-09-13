# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tournament do
    association :region
    association :season

    # Default location is University of Maryland College Park
    latitude 38.9854693
    longitude -76.9422359
  end
end
