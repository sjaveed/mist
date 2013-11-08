class Tournament < ActiveRecord::Base
  belongs_to :region
  belongs_to :season

  validates_presence_of :latitude
  validates_presence_of :longitude

  has_many :contests, :dependent => :destroy
  has_many :teams, :dependent => :destroy

  # A scope that orders all Tournaments in the database in order of proximity to the given coordinates.  The first
  # record is the Tournament closest to the given geographical coordinates.
  #
  # @param lat [float] the latitude of the coordinates
  # @param long [float] the longitude of the coordinates
  # @return [ActiveRecord::Relation] a Relation that you can add more scopes to if needed or just get the first element
  #   to find the closest Tournament to the given coordinates
  # @example Find the Tournament closest to Columbia, MD as follows:
  #   Tournament.order_by_proximity_to(39.203611, -76.856944).first
  def self.order_by_proximity_to lat = 0.0, long = 0.0
    order{(pow(latitude - lat, 2) + pow(longitude - long, 2)).asc}
  end

  # Create one Contest per active ContestTemplate for this Tournament
  def create_default_contests
    ContestTemplate.active.each do |template|
      c = template.build_contest_for self
      c.save
    end
  end
end
