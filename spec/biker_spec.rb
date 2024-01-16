require './lib/ride'
require './lib/biker'

RSpec.describe Biker do
    before do
        @biker = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    end
    describe "#initialize" do
        it 'exists' do
            expect(@biker).to be_a(Biker)
        end

        it 'has attributes and has a way to report that data' do
            expect(@biker.name).to eq("Kenny")

            expect(@biker.max_distance).to eq(30)

            expect(@biker.rides).to eq({})
            
            expect(@biker.acceptable_terrain).to eq([])
        end
    end

    describe "#learn_terrain!(terrain)" do
        it "can learn a terrain and return updated array" do
            @biker.learn_terrain!(:gravel)

            @biker.learn_terrain!(:hills)

            expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
        end
    end

    describe "#log_ride(ride, time)" do
        it "can log a ride when ride's terrain is acceptable, and if they can ride that distance. And return the updated hash" do
            @biker.learn_terrain!(:gravel)
            @biker.learn_terrain!(:hills)
            @biker.log_ride(@ride1, 92.5)
            @biker.log_ride(@ride1, 91.1)
            @biker.log_ride(@ride2, 60.9)
            @biker.log_ride(@ride2, 61.6)
            @biker2.log_ride(@ride2, 65.0)
            @biker2.learn_terrain!(:hills)
            @biker2.log_ride(@ride1, 95.0)
            
            expect(@biker.rides).to eq({@ride1 => [92.5, 91.1], @ride2 => [60.9, 61.6]})
            expect(@biker2.log_ride(@ride1, 95.0)).to eq("Biker Athena can't bike this distance")
            expect(@biker2.log_ride(@ride2, 61.6)).to eq("Biker Athena can't bike this terrain")
            expect(@biker2.rides).to eq({})
        end
    end

    describe "#personal record(ride)" do
        it "can report its personal record for a ride. This is the lowest time recorded for a ride. This method will return false if the Biker hasn't completed the ride" do
            @biker.learn_terrain!(:gravel)
            @biker.learn_terrain!(:hills)
            @biker2.learn_terrain!(:gravel)
            @biker.log_ride(@ride1, 92.5)
            @biker.log_ride(@ride1, 91.1)
            @biker.log_ride(@ride2, 60.9)
            @biker.log_ride(@ride2, 61.6)
            @biker2.log_ride(@ride1, 95.0)
            @biker2.log_ride(@ride2, 65.0)

            expect(@biker.personal_record(@ride1)).to eq(91.1)
            expect(@biker.personal_record(@ride2)).to eq(60.9)
            expect(@biker2.personal_record(@ride2)).to eq(65.0)
            expect(@biker2.personal_record(@ride1)).to eq(false)
        end
    end
end