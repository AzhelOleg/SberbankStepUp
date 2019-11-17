//
//  TouchIdAuthViewController.swift
//  SberbankStepUp
//
//  Created by Svetlana Timofeeva on 16/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit
import LocalAuthentication

public final class TouchIdAuthViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        title = "Touch Id Login"
        
        let gradient = GradientView()
        gradient.update()
        let backgroundLayer = gradient.gradientLayer
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, at: 0)
        
        authenticationWithTouchId()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
}


extension TouchIdAuthViewController {
    
    private func authenticationWithTouchId() {
        // 1. Create a authentication context
        let authenticationContext = LAContext()
        var error:NSError?
        // 2. Check if the device has a fingerprint sensor
        // If not, show the user an alert view and bail out!
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
        }
        
        // 3. Check the fingerprint
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Only awesome people are allowed",
            reply: { [unowned self] (success, error) -> Void in
                
                if success {
                    // Fingerprint recognized
                    // Go to view controller
                    DispatchQueue.global(qos: .background).async {
                        DispatchQueue.main.async {
                            // Run UI Updates
                            AppDelegate.shared.rootViewController.showMainScreen()
                        }
                    }
                }
                else {
                    // Check if there is an error
                    if let error = error {
                        //let message = self.errorMessageForLAErrorCode(errorCode: )
                        self.showAlertViewAfterEvaluatingPolicyWithMessage(message:  error.localizedDescription)
                    }
                }
        })
    }
    
    private func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        showAlertWithTitle(title: "Error", message: "This device does not have a TouchID sensor.")
    }
    
    private func showAlertViewAfterEvaluatingPolicyWithMessage( message:String ){
        showAlertWithTitle(title: "Error", message: message)
    }
    
    private func showAlertWithTitle( title:String, message:String ) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                // Run UI Updates
                self.present(alertVC, animated: true, completion: {})
            }
        }
    }
    
    private func errorMessageForLAErrorCode( errorCode:Int ) -> String{
        var message = ""
        
        switch errorCode {
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.biometryLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.biometryNotAvailable.rawValue:
            message = "Biometry is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
            
        }
        
        return message
    }
    
}
