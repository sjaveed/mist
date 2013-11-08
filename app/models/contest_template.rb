class ContestTemplate < ActiveRecord::Base
  belongs_to :category

  validates :name, presence: true, uniqueness: true

  scope :active, -> { where{active == true} }
end
