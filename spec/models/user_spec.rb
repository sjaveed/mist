require 'spec_helper'

describe User do
  it { should have_many(:registrations) }
  it { should have_many(:team_memberships) }
  it { should have_many(:teams).through(:team_memberships) }

  describe '#register' do
    let!(:user) { FactoryGirl.create(:user) }

    before(:each) do
      user.registrations = []
    end

    context 'given a valid contest' do
      let!(:contest) { FactoryGirl.create(:contest) }

      before(:each) do
        contest.registrations = []
      end

      context 'given no previous registrations for the user' do
        it 'should create a registration for the user' do
          expect{user.register(contest)}.to change{user.registrations.size}.from(0).to(1)
        end

        it 'should create a registration for the contest' do
          expect{user.register(contest)}.to change{contest.reload.registrations.size}.from(0).to(1)
        end
      end

      context 'given the user previously registered for a contest' do
        context 'in the same category' do
          let!(:other_contest) { FactoryGirl.create(:contest, category: contest.category, tournament: contest.tournament) }

          before(:each) { user.register(other_contest) }

          it 'should remove the registration for the previous contest' do
            expect{user.register(contest)}.to change{other_contest.reload.registrations.size}.from(1).to(0)
          end

          it 'should create a registration for the new contest' do
            expect{user.register(contest)}.to change{contest.reload.registrations.size}.from(0).to(1)
          end
        end

        context 'in a different category' do
          let!(:other_contest) { FactoryGirl.create(:contest, tournament: contest.tournament) }

          before(:each) { user.register(other_contest) }

          it 'should create another registration for the user' do
            expect{user.register(contest)}.to change{user.registrations.size}.from(1).to(2)
          end

          it 'should create a registration for the contest' do
            expect{user.register(contest)}.to change{contest.reload.registrations.size}.from(0).to(1)
          end

          it 'should not delete the registration for the other contest' do
            expect{user.register(contest)}.to_not change{other_contest.reload.registrations.size}
          end
        end
      end
    end

    context 'given an invalid contest' do
      it 'should throw a Registration::ContestNotFound exception' do
        expect{user.register(nil)}.to raise_error(Mist::Registration::ContestNotFound)
      end
    end
  end

  describe '#withdraw' do
    let!(:user) { FactoryGirl.create(:user) }

    context 'given a valid contest' do
      let!(:contest) { FactoryGirl.create(:contest) }

      context 'given the user previously registered for this contest' do
        before(:each) { user.register(contest) }

        it 'should remove a registration for the user' do
          expect{user.withdraw(contest)}.to change{user.reload.registrations.size}.from(1).to(0)
        end

        it 'should remove a registration for the contest' do
          expect{user.withdraw(contest)}.to change{contest.reload.registrations.size}.from(1).to(0)
        end
      end

      context 'given the user previously registered for another contest' do
        let!(:other_contest) { FactoryGirl.create(:contest, tournament: contest.tournament) }

        before(:each) { user.register(other_contest) }

        it 'should not remove a registration for the user' do
          expect{user.withdraw(contest)}.to_not change{user.reload.registrations.size}
        end

        it 'should not remove a registration for the contest' do
          expect{user.withdraw(contest)}.to_not change{contest.reload.registrations.size}
        end
      end
    end

    context 'given an invalid contest' do
      it 'should throw a Registration::ContestNotFound exception' do
        expect{user.withdraw(nil)}.to raise_error(Mist::Registration::ContestNotFound)
      end
    end
  end
end
