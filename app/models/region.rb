class Region < ActiveRecord::Base
  validates_presence_of :name

  has_many :tournaments, :dependent => :destroy
end
