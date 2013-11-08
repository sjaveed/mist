class ContestTemplate < ActiveRecord::Base
  belongs_to :category

  validates :name, presence: true, uniqueness: true

  scope :active, -> { where{active == true} }

  # Given a Tournament it returns a newly built (but not saved) Contest with data stored in the ContestTemplate
  # for the Tournament specified.
  #
  # @param tournament [Tournament] the tournament in which you'd like the new Contest to be built
  # @return [Contest] a Contest that you can optionally modify but that you must save to actually add it to the
  #   Tournament
  # @example Build and save a new Contest from an existing ContestTemplate as follows:
  #   tourney = Tournament.first
  #   template = ContestTemplate.first
  #   new_contest = template.build_contest_for(tourney)
  #   new_contest.save
  def build_contest_for tournament
    raise Mist::Registration::TournamentNotFound if tournament.nil?

    tournament.contests.build(name: name)
  end
end
