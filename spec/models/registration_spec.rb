require 'spec_helper'

describe Registration do
  it { should belong_to(:contest) }
  it { should belong_to(:user) }

  it { should validate_uniqueness_of(:contest_id).scoped_to(:user_id) }
end
