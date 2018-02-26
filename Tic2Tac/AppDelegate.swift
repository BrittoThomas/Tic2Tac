//
//  AppDelegate.swift
//  Tic2Tac
//
//  Created by apple on 23/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import GoogleMobileAds

enum GameMode {
    case easy
    case medium
    case hard
}

let ADMOB_APP_ID = "ca-app-pub-7677965624728255~4928354634"
let AD_UNIT_ID   = "ca-app-pub-7677965624728255/6979802902"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var shared = (UIApplication.shared.delegate as! AppDelegate)
    var window: UIWindow?
    var gameMode:GameMode = .easy

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
         GADMobileAds.configure(withApplicationID: ADMOB_APP_ID)
        return true
    }


}

