//
//  AppDelegate.swift
//  MBRACE-mobile-app
//
//  Created by Kamal Ali on 3/27/18.
//  Copyright © 2018 Kamal Ali. All rights reserved.
//

import UIKit

// Global constant attributes
let effectUtils = EffectUtilities()
let serverConn = ServerConnection()
let serverDataFilePrefix = "B4:E6:2D:15:87:C6"

// Global attributes
var serverInfo = ServerInformation()

// User default object
let objects = UserDefaults.standard

// App launch status enum
enum appLaunchStatus: Int {
    case firstLaunch = 0, notFirstLaunch
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let _DATA_KEY = "DATA_INFO"
    let _LAUNCH_KEY = "LAUNCH_KEY"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.save_data()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        self.load_data()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let main_sb = UIStoryboard(name: "Main", bundle: nil)
        var initialViewController: UIViewController!
        
        if (objects.integer(forKey: _LAUNCH_KEY) == appLaunchStatus.firstLaunch.rawValue || serverInfo.hostname.isEmpty) {
            // First launch
            initialViewController = main_sb.instantiateViewController(withIdentifier: "FirstLaunchViewController") as! FirstLaunchViewController
            objects.set(appLaunchStatus.notFirstLaunch.rawValue, forKey: _LAUNCH_KEY)
        } else if objects.integer(forKey: _LAUNCH_KEY) == appLaunchStatus.notFirstLaunch.rawValue {
            // Not first launch
            initialViewController = main_sb.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        }
        
        if initialViewController != nil {
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.save_data()
    }
    
    func save_data() {
        /* Saves current app data */
        let currhost = NSKeyedArchiver.archivedData(withRootObject: serverInfo.hostname)
        let currport = NSKeyedArchiver.archivedData(withRootObject: serverInfo.port)
        
        let enc_array: [Data] = [currhost, currport]
        UserDefaults.standard.set(enc_array, forKey: self._DATA_KEY)
        UserDefaults.standard.synchronize()
        print("Successfully saved data.")
    }
    
    func load_data() {
        /* Loads current data in user defaults */
        if let data: [Data] = UserDefaults.standard.object(forKey: self._DATA_KEY) as? [Data] {
            let savedhost = NSKeyedUnarchiver.unarchiveObject(with: data[0] as Data) as! String
            let savedport = NSKeyedUnarchiver.unarchiveObject(with: data[1] as Data) as! Int
            
            serverInfo.hostname = savedhost
            serverInfo.port = savedport
            print("Successfully loaded data.")
        }
    }
}

