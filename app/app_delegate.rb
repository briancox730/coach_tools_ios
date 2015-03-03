class AppDelegate < PM::Delegate
  def on_load(app, options)
    open ProgramScreen.new(nav_bar: true)
  end
end
