class BikeClub
    attr_reader :name, :bikers

    def initialize(name)
        @name = name
        @bikers = []
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

        group_ride
    end
end