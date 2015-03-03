class Program
  PROPERTIES = [:id, :name, :wods]
  PROPERTIES.each { |prop|
    attr_accessor prop
  }

  def initialize(hash={})
    hash.each { |key, value|
      if PROPERTIES.member? key.to_sym
        self.send((key.to_s + "=").to_s, value)
      end
    }
  end

  def wods
    @wods ||= []
  end

  def wods=(wods)
    if wods.first.is_a? HASH
      wods = wods.collect { |wod| Wod.new(wod) }
    end

    wods.each { |wod|
      if not wod.is_a? Wod
        raise "Wrong class for attemted wod #{wod.inspect}"
      end
    }

    @wods = wods
  end

  def self.all(&block)
    AFMotion::JSON.get("http://athletes-tools.herokuapp.com/v1/programs") do |response|

      if response.success?
        block.call(response.object)
      else
        block.call(nil)
      end
    end
  end

  def self.show(id, &block)
    AFMotion::JSON.get("http://athletes-tools.herokuapp.com/v1/programs/#{id}") do |response|

      if response.success?
        block.call(response.object)
      else
        block.call(nil)
      end
    end
  end
end
