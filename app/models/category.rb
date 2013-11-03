class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :contest_templates, :dependent => :destroy
  has_many :contests, :dependent => :destroy
end
