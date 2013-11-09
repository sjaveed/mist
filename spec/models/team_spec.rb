require 'spec_helper'

describe Team do
  it { should belong_to(:tournament) }

  it { should validate_presence_of(:name) }

  it { should have_many(:team_memberships) }
  it { should have_many(:users).through(:team_memberships) }

  describe '#validate_contest' do
    let(:contest) { FactoryGirl.create(:contest, minimum_competitors: 2, maximum_competitors: 3) }
    let(:team) { FactoryGirl.create(:team, tournament: contest.tournament) }
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let(:user3) { FactoryGirl.create(:user) }
    let(:user4) { FactoryGirl.create(:user) }

    before(:each) do
      user1.join_team(team)
      user2.join_team(team)
      user3.join_team(team)
      user4.join_team(team)
    end

    it 'should raise a ContestNotFound exception when called with nil' do
      expect{team.validate_contest(nil)}.to raise_error(Mist::Registration::ContestNotFound)
    end

    it 'should not raise any exception with zero enrollment' do
      expect{team.validate_contest(contest)}.to_not raise_exception
    end

    it 'should raise a ContestEnrollmentLow exception with too few users enrolled' do
      user1.register(contest)

      expect{team.validate_contest(contest)}.to raise_error(Mist::Registration::ContestEnrollmentLow)
    end

    it 'should not raise any exception with the minimum number of users enrolled' do
      user1.register(contest)
      user2.register(contest)

      expect{team.validate_contest(contest)}.to_not raise_exception
    end

    it 'should raise a ContestEnrollmentHigh exception with too many users enrolled' do
      user1.register(contest)
      user2.register(contest)
      user3.register(contest)
      user4.register(contest)

      expect{team.validate_contest(contest)}.to raise_error(Mist::Registration::ContestEnrollmentHigh)
    end
  end
end
