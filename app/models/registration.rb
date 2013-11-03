class Registration < ActiveRecord::Base
  belongs_to :contest
  belongs_to :user

  validates_uniqueness_of :contest_id, :scope => :user
end
