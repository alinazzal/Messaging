//
//  AppDelegate.swift
//  Messaging
//
//  Created by Ali Nazzal on 3/14/15.
//  Copyright (c) 2015 Ali Nazzal. All rights reserved.
//

import UIKit
import Bolts
import Parse
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SINClientDelegate {

    var window: UIWindow?
    var client: SINClient?
    var messageClient: SINMessageClient?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.enableLocalDatastore()
        Parse.setApplicationId(“abc”, clientKey: “abc”)
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:
            UIUserNotificationType.Sound | UIUserNotificationType.Alert,
            categories: nil
            ))
        
//        if launchOptions != nil {
//            if launchOptions![UIApplicationLaunchOptionsLocalNotificationKey] != nil {
//                handleLocalNotification(launchOptions![UIApplicationLaunchOptionsLocalNotificationKey] as UILocalNotification)
//            }
//        }
        
        return true
    }
    
    func sendTheMessage(messageText: NSString, recipientID: NSString) {
        var mes = SINOutgoingMessage(recipient: recipientID, text: messageText)
        self.messageClient!.sendMessage(mes)
    }
    
    func createSinchClient(userId: String) {
        if client == nil {
            client = Sinch.clientWithApplicationKey(“abc”, applicationSecret: “abc”, environmentHost: “abc”, userId: userId)
                        
            client!.setSupportMessaging(true)
            
            client!.delegate = self
            
            client!.start()
            
            client!.startListeningOnActiveConnection()
        }
    }
    
    func clientDidStart(client: SINClient) {
        NSLog("client did start")
        self.messageClient = self.client!.messageClient()
        
        self.messageClient!.delegate = MessagingController()
    }
    
    func clientDidStop(client: SINClient) {
        NSLog("client did stop")
    }
    
    func clientDidFail(client: SINClient, error: NSError!) {
        NSLog("client did fail", error.description)
        let toast = UIAlertView(title: "Failed to start", message: error.description, delegate: nil, cancelButtonTitle: "OK")
        toast.show()
    }
    
//    func handleLocalNotification(notification: UILocalNotification) {
//        if client != nil {
//            let result: SINNotificationResult = client!.relayLocalNotification(notification)
//            if result.isMessage() {
//                let msg = "Missed call from " + result.callResult().remoteUserId
//                let alert = UIAlertView()
//                alert.title = "Missed call"
//                alert.message = msg
//                alert.show()
//            }
//        }
//    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

