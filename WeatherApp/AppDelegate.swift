//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Тимофей Лукашевич on 18.09.20.
//  Copyright © 2020 Тимофей Лукашевич. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let todayForecastNetworkService = TodayNetworkService(location: CurrentLokationTaker())
        let todayForecastVC = TodayForecastPresenter(view: TodayForecastViewController(), networkService: todayForecastNetworkService)
        
        let weekForecastNetworkService = TodayNetworkService(location: CurrentLokationTaker())
        let weekForecastVC = TodayForecastPresenter(view: TodayForecastViewController(), networkService: weekForecastNetworkService)
        
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers(([todayForecastVC.view, weekForecastVC.view] as! [UIViewController]), animated: true)
        
        self.window?.rootViewController = tabBarVC
        self.window?.makeKeyAndVisible()
        
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

