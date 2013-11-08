class Contest < ActiveRecord::Base
  belongs_to :category
  belongs_to :contest_template
  belongs_to :tournament

  validates :name, presence: true, uniqueness: { scope: :tournament_id }
  validates_presence_of :minimum_competitors, :maximum_competitors
  validates_numericality_of :minimum_competitors, greater_than_or_equal_to: 1
  validates_numericality_of :maximum_competitors, :greater_than_or_equal_to => :minimum_competitors

  has_many :registrations, :dependent => :destroy
end
