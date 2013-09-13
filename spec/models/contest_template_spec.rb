require 'spec_helper'

describe ContestTemplate do
  it { should belong_to(:category) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
