class Tournament < ActiveRecord::Base
  belongs_to :region
  belongs_to :season
end
