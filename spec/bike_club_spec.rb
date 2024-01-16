require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
    before do
        @bikeclub1 = BikeClub.new("Roosters")
        @biker = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)
        @biker3 = Biker.new("Mario", 100)
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
        @biker3.log_ride(@ride1, 89.8)
        @biker3.log_ride(@ride2, 60.4)
    end
    describe "#initialize" do
        it 'exists' do
            expect(@bikeclub1).to be_a(BikeClub)
        end

        it 'has attributes and has a way to report that data' do
            expect(@bikeclub1.name).to eq("Roosters")

            expect(@bikeclub1.bikers).to eq([])

            expect(@bikeclub1.group_rides).to eq([])
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
        it "can tell which Biker has the best time for a given Ride." do
            @bikeclub1.add_biker(@biker)
            @bikeclub1.add_biker(@biker2)
            @bikeclub1.add_biker(@biker3)
            
            expect(@bikeclub1.best_time(@ride2)).to eq(@biker2)
            expect(@bikeclub1.best_time(@ride1)).to eq(@biker)

            @biker3.learn_terrain!(:hills)
            @biker3.log_ride(@ride1, 89.8)

            expect(@bikeclub1.best_time(@ride1)).to eq(@biker3)
        end
    end

    describe "bikers_eligible(ride)" do
        it "can tell which Bikers are eligible for a given Ride." do
            @bikeclub1.add_biker(@biker)
            @bikeclub1.add_biker(@biker2)

            expect(@bikeclub1.bikers_eligible(@ride1)).to eq([@biker])
            expect(@bikeclub1.bikers_eligible(@ride2)).to eq([@biker, @biker2])

            @biker3.learn_terrain!(:hills)
            @bikeclub1.add_biker(@biker3)

            expect(@bikeclub1.bikers_eligible(@ride1)).to eq([@biker, @biker3])
            expect(@bikeclub1.bikers_eligible(@ride2)).to eq([@biker, @biker2])

            @biker3.learn_terrain!(:gravel)

            expect(@bikeclub1.bikers_eligible(@ride2)).to eq([@biker, @biker2, @biker3])
        end
    end

    before do
        @bikeclub = BikeClub.new("Roosters")
        @bikera = Biker.new("Kenny", 30)
        @bikerb = Biker.new("Athena", 15)
        @bikerc = Biker.new("Mario", 100)
        @ride0 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
        @ride01 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
        @bikeclub.add_biker(@bikera)
        @bikeclub.add_biker(@bikerb)
        @bikeclub.add_biker(@bikerc)
        @bikera.learn_terrain!(:gravel)
        @bikera.learn_terrain!(:hills)
        @bikerb.learn_terrain!(:gravel)
        @bikerc.learn_terrain!(:hills)
        @bikera.log_ride(@ride0, 92.5)
        @bikera.log_ride(@ride01, 91.1)
        @bikera.log_ride(@ride01, 60.9)
        @bikera.log_ride(@ride01, 61.6)
        @bikerb.log_ride(@ride01, 65.0)
        @bikerb.log_ride(@ride01, 60.0)
        @bikerc.log_ride(@ride0, 89.8)
        @bikerc.log_ride(@ride01, 60.4)
    end

    describe "#record_group_ride(ride)" do
        it "returns a hash" do

            expect(@bikeclub.record_group_ride(@ride0)).to be_a(Hash)
        end

        it "returns a hash with start_time as key, pointing to a value of the ride's start time (a Time object)" do

            expect(@bikeclub.record_group_ride(@ride0)[:start_time]).to be_a(Time)
        end

        it "returns a hash with ride as key, pointing to a value of a Ride object" do

            expect(@bikeclub.record_group_ride(@ride0)[:ride]).to be_a(Ride)
            expect(@bikeclub.record_group_ride(@ride0)[:ride]).to eq(@ride0)
        end

        it "returns a hash with members as key, pointing to a value of an Array of Biker objects." do

            expect(@bikeclub.record_group_ride(@ride0)[:members]).to be_a(Array)
            expect(@bikeclub.record_group_ride(@ride0)[:members].all? {|member| member.class == Biker}).to be(true)
            expect(@bikeclub.record_group_ride(@ride0)[:members]).to eq([@bikera, @bikerc])
        end
    end
    
    describe "#group_rides" do
        it "records group rides" do
            group_ride1 = @bikeclub.record_group_ride(@ride0)
            group_ride2 = @bikeclub.record_group_ride(@ride1)

            expect(@bikeclub.group_rides.all? {|ride| ride.class == Hash}).to be(true)
            expect(@bikeclub.group_rides).to eq([group_ride1, group_ride2])
        end
    end
end