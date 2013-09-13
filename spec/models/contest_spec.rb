require 'spec_helper'

describe Contest do
  it { should belong_to(:category) }
  it { should belong_to(:tournament) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:tournament_id) }
end
