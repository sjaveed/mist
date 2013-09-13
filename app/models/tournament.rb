class Tournament < ActiveRecord::Base
  belongs_to :region
  belongs_to :season

  validates_presence_of :latitude
  validates_presence_of :longitude

  def self.order_by_proximity_to lat = 0.0, long = 0.0
    order{(pow(latitude - lat, 2) + pow(longitude - long, 2)).asc}
  end
end
