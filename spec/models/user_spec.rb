require 'spec_helper'

describe User do
  it { should have_many(:registrations) }

  describe '#register' do
    let!(:user) { FactoryGirl.create(:user) }

    before(:each) do
      user.registrations = []
      contest.registrations = []
    end

    context 'given a valid contest' do
      let!(:contest) { FactoryGirl.create(:contest) }

      context 'given no previous registrations for the user' do
        it 'should create a registration for the user' do
          expect{(user.register(contest))}.to change{user.registrations.size}.from(0).to(1)
        end

        it 'should create a registration for the contest' do
          expect{(user.register(contest))}.to change{contest.reload.registrations.size}.from(0).to(1)
        end
      end

      context 'given the user previously registered for a contest in a different category' do
        let!(:other_contest) { FactoryGirl.create(:contest, tournament: contest.tournament) }

        before(:each) { user.register(other_contest) }

        it 'should create another registration for the user' do
          expect{(user.register(contest))}.to change{user.registrations.size}.from(1).to(2)
        end

        it 'should create a registration for the contest' do
          expect{(user.register(contest))}.to change{contest.reload.registrations.size}.from(0).to(1)
        end

        it 'should not delete the registration for the other contest' do
          expect{(user.register(contest))}.to_not change{contest.registrations.size}
        end
      end
    end
  end
end
