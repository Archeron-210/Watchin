//
//  AppDelegate.swift
//  Watchin
//
//  Created by Archeron on 07/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // UINavigationBar appearance
        UINavigationBar.appearance().tintColor = UIColor.lightBlue
        if let customFont = UIFont(name: "Kohinoor Telugu", size: 22.0) {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .highlighted)
        }
        let navBarImage = UIImage(named: "navBarGradient")

        UINavigationBar.appearance().setBackgroundImage(navBarImage?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)

        // UITabBar appearance
        let tabBarImage = UIImage(named: "tabBarGradient")
        UITabBar.appearance().unselectedItemTintColor = .white
        UITabBar.appearance().backgroundImage = tabBarImage?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)

        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.lightBlue

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

