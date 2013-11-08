# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contest_template do
    association :category

    sequence(:name) {|n| "Contest Template #{n}" }
    active true
  end
end
