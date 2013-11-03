require 'spec_helper'

describe Season do
  it { should validate_presence_of(:name) }

  it { should have_many(:tournaments).dependent(:destroy) }
end
