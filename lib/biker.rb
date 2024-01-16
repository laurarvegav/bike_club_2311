class Biker
    attr_reader :name, 
                :max_distance,
                :rides,
                :acceptable_terrain

    def initialize(name, max_distance)
        @name = name
        @max_distance = max_distance
        @rides = Hash.new { |hash, key| hash[key] = [] }
        @acceptable_terrain = []
    end

    def learn_terrain!(terrain)
        @acceptable_terrain << terrain
    end

    def eligible_ride?(ride)
        eligible_distance?(ride) && acceptable_terrain?(ride)
    end

    def eligible_distance?(ride)
        ride.total_distance <= @max_distance
    end

    def acceptable_terrain?(ride)
        @acceptable_terrain.include?(ride.terrain)
    end

    def log_ride(ride, time)
        if eligible_ride?(ride)
            @rides[ride] << time 
        elsif !eligible_distance?(ride)
            "Biker #{@name} can't bike this distance"
        elsif !acceptable_terrain?(ride)
            "Biker #{@name} can't bike this terrain"
        end
    end

    def personal_record(ride)
        if @rides.key?(ride)
            personal_times = @rides[ride]
            personal_times.min
        else
            false
        end
    end
end