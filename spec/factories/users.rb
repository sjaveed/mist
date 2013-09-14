# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@mist.com" }
    password 'password'

    after(:build) { |u| u.skip_confirmation! }
  end
end
