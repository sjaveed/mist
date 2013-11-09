require 'spec_helper'

describe Contest do
  it { should belong_to(:category) }
  it { should belong_to(:contest_template) }
  it { should belong_to(:tournament) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:tournament_id) }
  it { should validate_presence_of(:minimum_competitors) }
  it { should validate_presence_of(:maximum_competitors) }
  it { should validate_numericality_of(:minimum_competitors).is_greater_than_or_equal_to(1) }
  it { should validate_numericality_of(:maximum_competitors).is_greater_than_or_equal_to(1) }

  it { should have_many(:registrations).dependent(:destroy) }
end
