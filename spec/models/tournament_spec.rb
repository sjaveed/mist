require 'spec_helper'

describe Tournament do
  it { should belong_to(:region) }
  it { should belong_to(:season) }

  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }

  it { should have_many(:contests).dependent(:destroy) }
  it { should have_many(:teams).dependent(:destroy) }

  describe '.order_by_proximity_to' do
    before :each do
      @dc = FactoryGirl.create :tournament
      @houston = FactoryGirl.create :tournament, latitude: 29.7675115, longitude: -95.3591109
      @atlanta = FactoryGirl.create :tournament, latitude: 33.7787785, longitude: -84.3972761

      @my_latitude = 39.1938439
      @my_longitude = -76.8650825
    end

    # ((latitude - lat) * (latitude - lat) + (longitude - long) * (longitude - long))
    # 29.7675115 - 39.1938439 * 29.7675115 - 39.1938439 + -95.3591109 - -76.8650825 * -95.3591109 - -76.8650825

    it 'should show DC as closest to me in Columbia, MD' do
      closest_tournament = Tournament.order_by_proximity_to(@my_latitude, @my_longitude).first

      expect(closest_tournament).to eq(@dc)
    end

    it 'should show Houston as farthest to me in Columbia, MD' do
      farthest_tournament = Tournament.order_by_proximity_to(@my_latitude, @my_longitude).last

      expect(farthest_tournament).to eq(@houston)
    end
  end

  describe '#create_default_contests' do
    let(:tourney) { FactoryGirl.create(:tournament) }
    let!(:inactive_template1) { FactoryGirl.create(:contest_template, active: false) }
    let!(:active_template1) { FactoryGirl.create(:contest_template) }
    let!(:active_template2) { FactoryGirl.create(:contest_template) }

    before(:each) do
      tourney.contests = []
    end

    it 'should create two new contests' do
      expect{tourney.create_default_contests}.to change{tourney.contests.size}.from(0).to(2)
    end

    it 'should create new contests from all active contest templates' do
      tourney.create_default_contests

      expect(tourney.contests.collect(&:name)).to include(active_template1.name, active_template2.name)
    end

    it 'should not create a contest from an inactive contest template' do
      tourney.create_default_contests

      expect(tourney.contests.collect(&:name)).to_not include(inactive_template1.name)
    end
  end
end
