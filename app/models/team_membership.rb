class TeamMembership < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :team_id
end
