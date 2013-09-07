class Tournament < ActiveRecord::Base
  belongs_to :region
  belongs_to :season

  validates_presence_of :latitude
  validates_presence_of :longitude

  def self.order_by_proximity_to lat, long
    lat ||= 0
    long ||= 0

    order{((latitude - lat) * (latitude - lat) + (longitude - long) * (longitude - long)).desc}
  end
end
