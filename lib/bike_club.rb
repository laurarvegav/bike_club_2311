class BikeClub
    attr_reader :name, 
                :bikers, 
                :group_rides

    def initialize(name)
        @name = name
        @bikers = []
        @group_rides = []
    end

    def add_biker(biker)
        @bikers << biker
        @bikers
    end

    def most_rides
        @bikers.max_by do |biker|
            biker.rides.size
        end
    end

    def best_time(given_ride)
        best_biker = nil
        best_time = nil

        @bikers.each do |biker|
            time = biker.personal_record(given_ride)
            if time && (best_time.nil? || time < best_time)
                best_biker = biker
                best_time = time
            end
        end
        best_biker
    end

    def bikers_eligible(given_ride)
        eligible_bikers = []
        @bikers.each do |biker|      
            if biker.eligible_ride?(given_ride)
                eligible_bikers << biker 
            end
        end
        eligible_bikers
    end

    def record_group_ride(given_ride)
        group_ride = {}
        group_ride[:start_time] = Time.new
        group_ride[:ride] = given_ride
        group_ride[:members] = bikers_eligible(given_ride)

        @group_rides << group_ride
        group_ride
    end

    def finish_rider_time(biker, ride)
        start_time = nil
        
        duration_time = Time.new - start_time
        
        @group_rides.each do |group_ride|
            group_ride[:start_time] if group_ride[:ride] == ride
        end

        biker.log_ride(ride, duration_timetime)
    end

    def self.best_rider
        best_riders = []
        @group_rides.each do |group_ride|
            best_riders << best_time(group_ride[:ride])
        end
        best_riders.mode
    end
end