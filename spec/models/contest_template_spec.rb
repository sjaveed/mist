require 'spec_helper'

describe ContestTemplate do
  it { should belong_to(:category) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe '.active (scope)' do
    context 'given an inactive and an active template' do
      let! (:inactive_template) { FactoryGirl.create(:contest_template, active: false) }
      let! (:active_template) { FactoryGirl.create(:contest_template) }

      it 'should only return one template' do
        expect(ContestTemplate.active.size).to eq(1)
      end

      it 'should only return the active template' do
        expect(ContestTemplate.active.first.id).to equal(active_template.id)
      end
    end

    context 'given two active templates' do
      let! (:active_template1) { FactoryGirl.create(:contest_template) }
      let! (:active_template2) { FactoryGirl.create(:contest_template) }

      it 'should return two templates' do
        expect(ContestTemplate.active.size).to eq(2)
      end

      it 'should return the both templates' do
        expect(ContestTemplate.active.collect(&:id)).to include(active_template1.id, active_template2.id)
      end
    end

    context 'given two inactive templates' do
      let! (:inactive_template1) { FactoryGirl.create(:contest_template, active: false) }
      let! (:inactive_template2) { FactoryGirl.create(:contest_template, active: false) }

      it 'should return zero templates' do
        expect(ContestTemplate.active.size).to eq(0)
      end

      it 'should return neither of the templates' do
        expect(ContestTemplate.active.collect(&:id)).to_not include(inactive_template1.id, inactive_template2.id)
      end
    end
  end

  describe '#build_contest_for' do
    let(:template) { FactoryGirl.create(:contest_template) }

    context 'given a tournament' do
      let(:tourney) { FactoryGirl.create(:tournament) }

      before(:each) do
        @contest = template.build_contest_for(tourney)
      end

      it 'should return a newly built contest' do
        expect(@contest).to be_a_new(Contest)
      end

      context 'the resulting built contest' do
        it 'should have the same name as the contest template' do
          expect(@contest.name).to eq(template.name)
        end

        it 'should belong to the tournament specified' do
          expect(@contest.tournament).to eq(tourney)
        end
      end
    end

    context 'given a nil tournament' do
      it 'should raise a Registration::TournamentNotFound exception' do
        expect{template.build_contest_for(nil)}.to raise_error(Mist::Registration::TournamentNotFound)
      end
    end
  end
end
