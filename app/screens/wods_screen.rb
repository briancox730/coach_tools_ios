class WodsScreen < PM::TableScreen
  attr_accessor :id, :name
  title "#{name}"


  def table_data
    [{
      cells: Array(@wods)
      }]
  end

  def on_load

    set_attributes self.view, {
      background_color: hex_color("#FFFFFF")
    }

    Program.show(id) do |response|
      @wods = response["wods"].sort_by{|p| p["name"]}.reverse.map { |p|
        {
          title: p["name"],
          action: :tap_wod,
          arguments: { id: p["id"], title: p["name"] }
        }
      }

      update_table_data
    end
  end

  def tap_wod(args={})
    open WodScreen.new(args)
  end
end
