class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :registrations

  def register new_contest
    raise Mist::Registration::ContestNotFound.new if new_contest.nil?

    prior_registrations = registrations.joins{contest}.where{contest.category_id == new_contest.category_id}.readonly(false)

    prior_registrations.destroy_all if prior_registrations.any?

    registrations.create(contest: new_contest)
  end

  def withdraw existing_contest
    raise Mist::Registration::ContestNotFound.new if existing_contest.nil?

    registrations.where{contest_id == existing_contest.id}.destroy_all
  end
end
