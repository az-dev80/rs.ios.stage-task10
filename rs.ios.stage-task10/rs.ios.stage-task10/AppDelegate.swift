//
//  AppDelegate.swift
//  rs.ios.stage-task10
//
//  Created by Albert Zhloba on 27.08.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let mainVC = ViewController()
        let navVC = NavigationController()
        //navVC.title = "Settings"
        //let secVC = SecondaryViewController()
        //secVC.title = "Settings"
        //mainTabBarController.viewControllers = [mainVC, navVC]
        //mainVC.tabBarItem.standardAppearance(
        //mainVC.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
       // secVC.tabBarItem.image = UIImage(systemName: "gear")
        navVC.viewControllers = [mainVC]
        UINavigationBar.appearance().tintColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        
        UINavigationBar.appearance().isTranslucent = false
        navVC.navigationBar.barTintColor = UIColor(red: 0.137, green: 0.137, blue: 0.137, alpha: 1)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        //window?.backgroundColor = .green
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

