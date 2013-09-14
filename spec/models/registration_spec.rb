require 'spec_helper'

describe Registration do
  it { should belong_to(:contest) }
  it { should belong_to(:user) }
end
