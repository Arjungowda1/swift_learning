//
//  AppDelegate.swift
//  trackPro
//
//  Created by IOSLevel-01 on 18/02/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
typealias ResponseHandlerBlock = ( _ responseObject : AnyObject, _ errorObject : NSError?) -> ()
typealias ResponseHandlerBlock1 = ( _ responseObject : Int) -> ()
typealias ResponseHandlerBlock2 = ( _ responseObject : Int,Int,Int,Int) -> ()
typealias ResponseHandlerBlock3 = ( _ responseObject : Int,Int) -> ()
typealias ResponseHandlerBlock4 = ( _ responseObject : [String]) -> ()
let defaults = UserDefaults.standard

let notificationCenter = UNUserNotificationCenter.current()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    override init() {
       super.init()
       FirebaseApp.configure()
       // not really needed unless you really need it FIRDatabase.database().persistenceEnabled = true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        FirebaseApp.configure()
        notificationCenter.delegate = self as! UNUserNotificationCenterDelegate
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
         (didAllow, error) in
         if !didAllow {
          print("User has declined notifications")
         }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

@available(iOS 12.0, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
 
 func userNotificationCenter(_ center: UNUserNotificationCenter,
                             willPresent notification: UNNotification,
                             withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
  
  completionHandler([.alert, .sound])
 }
 
 func userNotificationCenter(_ center: UNUserNotificationCenter,
                             didReceive response: UNNotificationResponse,
                             withCompletionHandler completionHandler: @escaping () -> Void) {
  
  if response.notification.request.identifier == "Local Notification" {
   print("Handling notifications with the Local Notification Identifier")
  }
  
  completionHandler()
 }
 
 func scheduleNotification(notificationType: String, body:String) {
  
  let content = UNMutableNotificationContent() // Содержимое уведомления
  let categoryIdentifier = "Delete Notification Type"
  
  content.title = notificationType
  content.body = body + notificationType
  content.sound = UNNotificationSound.default
  content.badge = 1
  content.categoryIdentifier = categoryIdentifier
  
  let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
  let identifier = "Local Notification"
  let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
  
  notificationCenter.add(request) { (error) in
   if let error = error {
    print("Error \(error.localizedDescription)")
   }
  }
  
  let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
  let deleteAction = UNNotificationAction(identifier: "DeleteAction", title: "Delete", options: [.destructive])
  let category = UNNotificationCategory(identifier: categoryIdentifier,
           actions: [snoozeAction, deleteAction],
           intentIdentifiers: [],
           options: [])
  
  notificationCenter.setNotificationCategories([category])
 }
}

