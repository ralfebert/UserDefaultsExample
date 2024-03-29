import UIKit

@UIApplicationMain
class UserDefaultsExampleApp: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UserDefaultsViewController()
        self.window = window
        window.makeKeyAndVisible()

        return true
    }

}
