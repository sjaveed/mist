require 'spec_helper'

describe Tournament do
  it { should belong_to(:region) }
  it { should belong_to(:season) }
end
