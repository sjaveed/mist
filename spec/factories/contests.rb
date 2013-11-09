# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contest do
    association :category
    association :tournament

    sequence(:name) {|n| "Contest #{n}" }
    minimum_competitors 1
    maximum_competitors 2
  end
end
