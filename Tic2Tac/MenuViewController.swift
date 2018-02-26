//
//  MenuViewController.swift
//  Tic2Tac
//
//  Created by apple on 24/02/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MenuViewController: UIViewController {
    @IBOutlet weak var buttonEasy: UIButton!
    @IBOutlet weak var buttonMedium: UIButton!
    @IBOutlet weak var buttonHard: UIButton!
    @IBOutlet weak var buttonBack: UIBarButtonItem!
    var viewController:ViewController?{
        return self.presentingViewController as? ViewController
    }
    
    let buttonBackgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.2, alpha: 1.0)
    var interstitial: GADInterstitial!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.buttonEasy.layer.cornerRadius = 5.0
        self.buttonMedium.layer.cornerRadius = 5.0
        self.buttonHard.layer.cornerRadius = 5.0
        self.buttonEasy.layer.borderWidth = 2.0
        self.buttonMedium.layer.borderWidth = 2.0
        self.buttonHard.layer.borderWidth = 2.0
        

        self.buttonEasy.layer.borderColor = buttonBackgroundColor.cgColor
        self.buttonMedium.layer.borderColor = buttonBackgroundColor.cgColor
        self.buttonHard.layer.borderColor = buttonBackgroundColor.cgColor
        
        self.setButtonSelected()
        
        interstitial = GADInterstitial(adUnitID: AD_UNIT_ID)
        interstitial.delegate = self
        let request = GADRequest()
        request.testDevices = ["be79d699004878711d34628e79ee126e"]
        interstitial.load(request)

    }

    override func viewWillAppear(_ animated: Bool) {

    }
    
    func setButtonSelected() {
        switch AppDelegate.shared.gameMode {
        case .easy:
            self.buttonEasy.backgroundColor = buttonBackgroundColor
            self.buttonMedium.backgroundColor = .white
            self.buttonHard.backgroundColor = .white
            
            self.buttonEasy.setTitleColor(.white, for: .normal)
            self.buttonMedium.setTitleColor(buttonBackgroundColor, for: .normal)
            self.buttonHard.setTitleColor(buttonBackgroundColor, for: .normal)
            
        case .medium:
            self.buttonEasy.backgroundColor = .white
            self.buttonMedium.backgroundColor = buttonBackgroundColor
            self.buttonHard.backgroundColor = .white
            
            self.buttonEasy.setTitleColor(buttonBackgroundColor, for: .normal)
            self.buttonMedium.setTitleColor(.white, for: .normal)
            self.buttonHard.setTitleColor(buttonBackgroundColor, for: .normal)
            
        case .hard:
            self.buttonEasy.backgroundColor = .white
            self.buttonMedium.backgroundColor = .white
            self.buttonHard.backgroundColor = buttonBackgroundColor
            
            self.buttonEasy.setTitleColor(buttonBackgroundColor, for: .normal)
            self.buttonMedium.setTitleColor(buttonBackgroundColor, for: .normal)
            self.buttonHard.setTitleColor(.white, for: .normal)

        }
        
        viewController?.resetTicTac()
    }
    
    func showAd()  {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    @IBAction func buttonActionEasy(_ sender: Any) {
        AppDelegate.shared.gameMode = .easy
        self.setButtonSelected()
        self.showAd()
    }
    
    @IBAction func buttonActionMedium(_ sender: Any) {
        AppDelegate.shared.gameMode = .medium
        self.setButtonSelected()
        self.showAd()
    }
    
    @IBAction func buttonActionHard(_ sender: Any) {
        AppDelegate.shared.gameMode = .hard
        self.setButtonSelected()
        self.showAd()
    }
    
    @IBAction func buttonActionBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
}

extension MenuViewController: GADInterstitialDelegate {
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}
