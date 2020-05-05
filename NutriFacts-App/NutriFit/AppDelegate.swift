//
//  AppDelegate.swift
//  NutriFit
//
//  Created by Denis Tatar on 2020-05-02.
//  Copyright © 2020 Denis Tatar. All rights reserved.
//

import UIKit
import Firebase
// Adding Google Sign In by using the steps from the following link: https://developers.google.com/identity/sign-in/ios/sign-in?ver=swift
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    //func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    //    return
    // }
    

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Adding Google Sign In option!
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "906819358039-6s6s78aqgmv6abi1s7m26u16mlof6qpp.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        FirebaseApp.configure()
        return true
    }
    
    // Adding Google Sign In option to our app
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    // Adding Google Sign In option to our app
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    // Checking if our user has properly been able to sign in using GoogleSign iN
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    if let error = error {
      if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
        print("The user has not signed in before or they have since signed out.")
      } else {
        print("\(error.localizedDescription)")
      }
      return
    }
    // Sign in worked, let's store the values we need!
    // Perform any operations on signed in user here.
    let userId = user.userID                  // For client-side use only!
    let idToken = user.authentication.idToken // Safe to send to the server
    let fullName = user.profile.name
    let givenName = user.profile.givenName
    let familyName = user.profile.familyName
    let email = user.profile.email
    }
    
    // Function used to send a message to the user if they disconnect from sign in
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // Printing our error message
      print("User has disconnected")
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

