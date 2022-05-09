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
        UINavigationBar.appearance().tintColor = UIColor.white
        setNavigationBarAppearance()

        // UITabBar appearance
        UITabBar.appearance().unselectedItemTintColor = .white

        // alerts tint
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.lightBlue

        return true
    }

    func setNavigationBarAppearance() {
        let navBarAppearance = UINavigationBar.appearance()
        let navigationBarAppearance = UINavigationBarAppearance()

        let titleFontAttrs = [ NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu", size: 22)!, NSAttributedString.Key.foregroundColor: UIColor.white ]
        let barButtonFontAttrs = [ NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu", size: 22)! ]
        navigationBarAppearance.titleTextAttributes = titleFontAttrs
        navigationBarAppearance.buttonAppearance.normal.titleTextAttributes = barButtonFontAttrs
        navigationBarAppearance.buttonAppearance.highlighted.titleTextAttributes = barButtonFontAttrs

        navigationBarAppearance.backgroundEffect = .none
        navigationBarAppearance.backgroundImage = UIImage(named: "tabBarGradient")

        navigationBarAppearance.shadowImage = UIImage()
        navigationBarAppearance.shadowColor = .clear

        navBarAppearance.standardAppearance = navigationBarAppearance
        navBarAppearance.scrollEdgeAppearance = navBarAppearance.standardAppearance
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

