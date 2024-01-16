require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
    before do
        @bikeclub1 = BikeClub.new("Roosters")
        @biker = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
        @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
        @biker.learn_terrain!(:gravel)
        @biker.learn_terrain!(:hills)
        @biker2.learn_terrain!(:gravel)
        @biker.log_ride(@ride1, 92.5)
        @biker.log_ride(@ride1, 91.1)
        @biker.log_ride(@ride2, 60.9)
        @biker.log_ride(@ride2, 61.6)
        @biker2.log_ride(@ride2, 65.0)
        @biker2.log_ride(@ride2, 60.0)
    end
    describe "#initialize" do
        it 'exists' do
            expect(@bikeclub1).to be_a(BikeClub)
        end

        it 'has attributes and has a way to report that data' do
            expect(@bikeclub1.name).to eq("Roosters")

            expect(@bikeclub1.bikers).to eq([])
        end
    end

    describe "#add_biker(biker)" do
        it "can add bikers and return updated array" do
            @bikeclub1.add_biker(@biker)
            @bikeclub1.add_biker(@biker2)
            
            expect(@bikeclub1.bikers).to eq([@biker, @biker2])
        end
    end

    describe "#most_rides" do
        it "can tell which Biker has logged the most rides." do
            @bikeclub1.add_biker(@biker)
            @bikeclub1.add_biker(@biker2)
            
            expect(@bikeclub1.most_rides).to eq(@biker)
        end
    end

    describe "#best_time(ride)" do
        it "can tell us which Biker has the best time for a given Ride." do
            @bikeclub1.add_biker(@biker)
            @bikeclub1.add_biker(@biker2)
            
            expect(@bikeclub1.best_time(@ride2)).to eq(@biker2)
        end
    end
end