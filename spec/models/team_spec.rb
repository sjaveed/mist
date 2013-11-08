require 'spec_helper'

describe Team do
  it { should belong_to(:tournament) }

  it { should validate_presence_of(:name) }

  it { should have_many(:team_memberships) }
  it { should have_many(:users).through(:team_memberships) }
end
