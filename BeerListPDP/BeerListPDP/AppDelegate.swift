//
//  AppDelegate.swift
//  BeerListPDP
//
//  Created by Ramiro Neto on 27/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = self.window!.rootViewController as! UINavigationController

        BeerListModule.shared.assembleModule(in: navigationController)
        return true
    }

}
