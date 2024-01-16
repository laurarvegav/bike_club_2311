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

    def log_ride(ride, time)
        if ride.total_distance > @max_distance
            "Biker #{@name} can't bike this distance"
        elsif !@acceptable_terrain.include?(ride.terrain)
            "Biker #{@name} can't bike this terrain"
        else        
            @rides[ride] << time 
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