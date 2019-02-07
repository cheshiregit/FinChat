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
    
    struct Stack {
        var array: [String] = []
        mutating func push(_ element: String) {
            array.append(element)
        }
        mutating func pop() -> String? {
            return array.popLast()
        }
    }
    
    var state = Stack()
    
    func temporaryState() -> String {
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
    
    let logging: Bool = true

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if logging {
            print("From \(state.pop() ?? " ") to \(self.temporaryState())")
            state.push(self.temporaryState())
            print(#function)
        }
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if logging {
            print("From \(state.pop() ?? " ") to \(self.temporaryState())")
            state.push(self.temporaryState())
            print(#function)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if logging {
            print("From \(state.pop() ?? " ") to \(self.temporaryState())")
            state.push(self.temporaryState())
            print(#function)
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if logging {
            print("From \(state.pop() ?? " ") to \(self.temporaryState())")
            state.push(self.temporaryState())
            print(#function)
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        if logging {
            print("From \(state.pop() ?? " ") to \(self.temporaryState())")
            state.push(self.temporaryState())
            print(#function)
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if logging {
            print("From \(state.pop() ?? " ") to \(self.temporaryState())")
            state.push(self.temporaryState())
            print(#function)
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        if logging {
            print("From \(state.pop() ?? " ") to \(self.temporaryState())")
            state.push(self.temporaryState())
            print(#function)
        }
    }


}

