class ProgramScreen < PM::TableScreen
  title "Programs"

  def table_data
    [{
      cells: Array(@programs)
      }]
  end

  def on_load
    set_attributes self.view, {
      background_color: hex_color("#FFFFFF")
    }

    Program.all do |response|
      @programs = response.map { |p|
        {
          title: p["name"],
          action: :tap_program,
          arguments: { id: p["id"], title: p["name"] }
        }
      }
      update_table_data
    end
  end

  def tap_program(args={})
    open WodsScreen.new(args)
  end
end
