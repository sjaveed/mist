class Team < ActiveRecord::Base
  belongs_to :tournament

  validates_presence_of :name

  has_many :team_memberships
  has_many :users, :through => :team_memberships

  # Check a team's members' registrations for the specified contest.  It checks that the number of team members
  # from this team that are registered for the given contest are greater than or equal to the team minimum
  # and less than or equal to the team maximum
  #
  # @param contest [Contest] the contest that you'd like to validate this team's registration for
  # @return [void]
  # @raise [Mist::Registration::ContestNotFound] if contest is nil
  # @raise [Mist::Registration::ContestEnrollmentLow] if the number of this team's members who have registered for
  #   the specified contest are lower than the minimum number required by the contest.  This limit is determined by
  #   the minimum_competitors field of [Contest]
  # @raise [Mist::Registration::ContestEnrollmentHigh] if the number of this team's members who have registered for
  #   the specified contest are higher than the maximum number required by the contest.  This limit is determined by
  #   the maximum_competitors field of [Contest]
  def validate_contest contest
    raise Mist::Registration::ContestNotFound.new if contest.nil?

    enrollment = users.joins{registrations}.where{registrations.contest_id == Contest.last}.size
    return if enrollment.zero?

    raise Mist::Registration::ContestEnrollmentLow if enrollment < contest.minimum_competitors
    raise Mist::Registration::ContestEnrollmentHigh if enrollment > contest.maximum_competitors
  end
end
