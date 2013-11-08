class ContestTemplate < ActiveRecord::Base
  belongs_to :category

  validates :name, presence: true, uniqueness: true
  validates_presence_of :minimum_competitors, :maximum_competitors
  validates_numericality_of :minimum_competitors, greater_than_or_equal_to: 1
  validates_numericality_of :maximum_competitors, :greater_than_or_equal_to => :minimum_competitors

  has_many :contests

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

    tournament.contests.build(transferable_attributes)
  end

  private

  # This method returns a hash of all the attributes (and corresponding values) that a ContestTemplate transfers to
  # any Contests it builds
  # @private
  def transferable_attributes
    {
        contest_template_id: id,
        name: name,
        minimum_competitors: minimum_competitors,
        maximum_competitors: maximum_competitors
    }
  end
end
