class WodScreen < PM::TableScreen
  attr_accessor :id, :name
  title "#{name}"

  def table_data
    [{
      cells: Array(@workouts)
      }]
  end

  def on_load
    set_attributes self.view, {
      background_color: hex_color("#FFFFFF")
    }

    Wod.show(id) do |response|
      @workouts = response["workouts"].sort_by{|p| p["name"]}.map { |p|
        {
          title: "#{p["name"]}. #{p["description"].gsub("\n", "")}",
          action: :tap_workout,
          arguments: { id: p["id"], title: p["name"] }
        }
      }

      update_table_data
    end
  end

  def tap_workout(args={})
    PM.logger.info args[:id]
  end
end
