require 'spec_helper'

describe TeamMembership do
  it { should belong_to(:team) }
  it { should belong_to(:user) }

  it { should validate_uniqueness_of(:user_id).scoped_to(:team_id) }
end
