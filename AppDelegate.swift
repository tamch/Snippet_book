//
//  AppDelegate.swift
//  Snippets
//
//  Created by Jak Tiano on 8/7/16.
//  Copyright © 2016 PacktPub. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    enum ShortcutItems : String {
        case newText = "com.PacktPub.Snippets.createTextSnippet"
        case newPhoto = "com.PacktPub.Snippets.createPhotoSnippet"
    }

    
    var window: UIWindow?
    

    func handleShortcut(_ shortcutItem: UIApplicationShortcutItem) {
        switch shortcutItem.type {
            case ShortcutItems.newText.rawValue:
                let vc = self.window!.rootViewController as! ViewController
                vc.createNewTextSnippet()
                
            case ShortcutItems.newPhoto.rawValue:
                let vc = self.window!.rootViewController as! ViewController
                vc.createNewPhotoSnippet()
                
            default:
                break
        }
    }


    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let vc = self.window!.rootViewController!
        if vc.presentedViewController != nil {
            let alert = UIAlertController(title: "Unfinished Snippet", message: "Do you want to continue creating this snippet, or erase and start a new snippet?", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Continue", style: .default, handler: nil)
            let eraseAction = UIAlertAction(title: "Erase", style: .destructive) { (alert: UIAlertAction!) -> Void in
                vc.dismiss(animated: true, completion: nil)
                self.handleShortcut(shortcutItem)
            }
            
            alert.addAction(continueAction)
            alert.addAction(eraseAction)
            vc.presentedViewController!.present(alert, animated: true, completion: nil)
        } else {
            handleShortcut(shortcutItem)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
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

