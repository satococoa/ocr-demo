class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(App.bounds)
    @controller = MainController.new
    @window.rootViewController = @controller
    @window.makeKeyAndVisible
    true
  end
end
