class Team < ActiveRecord::Base
  belongs_to :tournament

  validates_presence_of :name

  has_many :team_memberships
  has_many :users, :through => :team_memberships
end
