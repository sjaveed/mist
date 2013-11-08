class Contest < ActiveRecord::Base
  belongs_to :category
  belongs_to :contest_template
  belongs_to :tournament

  validates :name, presence: true, uniqueness: { scope: :tournament_id }

  has_many :registrations, :dependent => :destroy
end
