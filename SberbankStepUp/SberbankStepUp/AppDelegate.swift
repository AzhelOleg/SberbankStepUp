//
//  AppDelegate.swift
//  SberbankStepUp
//
//  Created by Svetlana Timofeeva on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //
		window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
		//
        
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        AppDelegate.shared.rootViewController.switchToTouchIdAuthScreen()
    }
}

extension AppDelegate {
    
    public static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    public var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
}

