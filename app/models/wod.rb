class Wod
  PROPERTIES = [:id, :name, :workouts]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(hash = {})
    hash.each { |key, value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + "=").to_s, value)
      end
    }
  end

  def workouts
    @workouts ||= []
  end

  def workouts=(workouts)
    if workouts.first.is_a? Hash
      workouts = workouts.collect { |workout| Workout.new(workout) }
    end

    workouts.each { |workout|
      if not workout.is_a? Workout
        raise "Wrong class for attempted workout #{workout.inspect}"
      end
    }

    @workouts = workouts
  end

  def self.show(id, &block)
    AFMotion::JSON.get("http://athletes-tools.herokuapp.com/v1/wods/#{id}") do |response|

      if response.success?
        block.call(response.object)
      else
        block.call(nil)
      end
    end
  end
end
