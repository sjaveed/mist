# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    sequence(:name) {|n| "Team #{n}" }
    association :tournament

    registration_open false
  end
end
