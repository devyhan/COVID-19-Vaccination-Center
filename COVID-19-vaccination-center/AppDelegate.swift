//
//  AppDelegate.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let viewController = VaccinationCenterVC()
    self.window?.overrideUserInterfaceStyle = .light
    self.window?.rootViewController = UINavigationController(rootViewController: viewController)
    self.window?.makeKeyAndVisible()
    return true
  }
}

