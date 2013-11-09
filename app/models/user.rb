class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :registrations
  has_many :team_memberships
  has_many :teams, :through => :team_memberships

  # Register this User for the given Contest
  #
  # @param new_contest [Contest] the Contest that you want this User to register for
  # @return [void]
  # @raise [Mist::Registration::ContestNotFound] if new_contest is nil
  def register new_contest
    raise Mist::Registration::ContestNotFound.new if new_contest.nil?

    prior_registrations = registrations.joins{contest}.where{contest.category_id == new_contest.category_id}.readonly(false)

    prior_registrations.destroy_all if prior_registrations.any?

    registrations.create(contest: new_contest)
  end

  # Withdraw this User from the given Contest
  #
  # @param existing_contest [Contest] the Contest that you want this User to withdraw from
  # @return [void]
  # @raise [Mist::Registration::ContestNotFound] if new_contest is nil
  def withdraw existing_contest
    raise Mist::Registration::ContestNotFound.new if existing_contest.nil?

    registrations.where{contest_id == existing_contest.id}.destroy_all
  end

  def join_team new_team
    raise Mist::Registration::TeamNotFound.new if new_team.nil?

    team_memberships.create(team: new_team)
  end
end
