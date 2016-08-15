//
//  AppDelegate.swift
//  FamilyPhone
//
//  Created by Robin Reynolds on 6/27/15.
//  Copyright (c) 2015 Robin Reynolds. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        FamilyTree.loadData()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        FamilyTree.saveData()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        FamilyTree.loadData()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        FamilyTree.saveData()
    }

/*
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        
        let fileManager = NSFileManager()
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSUserDomainMask, true)
        let docDirectory = paths[0]
        let inboxPath = docDirectory.stringByAppendingString("Inbox")
        do {
            var dirFiles = [String]()
            try dirFiles = fileManager.contentsOfDirectoryAtPath(inboxPath)
        }
        catch {
            // do something
        }

        
//        NSFileManager *filemgr = [NSFileManager defaultManager];
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString* inboxPath = [documentsDirectory stringByAppendingPathComponent:@"Inbox"];
//        NSArray *dirFiles = [filemgr contentsOfDirectoryAtPath:inboxPath error:nil];
    }
    */
    
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        let data = NSData(contentsOfURL: url)
        FamilyTree.loadFamiliesWithData(data)
        return true
    }


}

