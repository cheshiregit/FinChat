//
//  AppDelegate.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 07/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var state: String = ""
    
    var temporaryState: String {
        switch UIApplication.shared.applicationState {
        case .active:
            return "UIApplicationStateActive"
        case .inactive:
            return "UIApplicationStateInactive"
        case .background:
            return "UIApplicationStateBackground"
        default:
            break
        }
        return ""
    }
    
    let loggingOn: Bool = true
    
    func logging(_ function: String = #function) {
        if loggingOn {
            print("From \(state) to \(temporaryState)")
            state = temporaryState
            print(function)
        }
    }

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        logging()
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        logging()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        logging()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        logging()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        logging()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        logging()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        logging()
    }


}

