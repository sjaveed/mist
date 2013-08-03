# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :season do
    sequence(:name) {|n| "Season #{2000 + n}" }
  end
end
