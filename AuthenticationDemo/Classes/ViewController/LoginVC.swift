//
//  ViewController.swift
//  AuthenticationDemo
//
//  Created by Mohini Sindhu  on 28/07/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginVC: UIViewController {
	
	// IBOutlets
	@IBOutlet weak var authenticationButton : UIButton!
	
	
	//MARK: View lifecycle methods
	override func viewDidLoad(){
		super.viewDidLoad()
		initialVCSetup()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	//MARK: Initial Methods
	func initialVCSetup(){
		title = "Login"
		
		// authentication button appearances
		self.authenticationButton.backgroundColor = Define.ColorConstants.kAppMainColor
		self.authenticationButton.tintColor = Define.ColorConstants.kBaseColor
		
	}
	
	//MARK: Private methods
	func handleTouch(){
		
		let laContext = LAContext()
		var error : NSError? = nil
		let reasonString = "Authentication is required for you to use this application"
		
		if  laContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
		{
			laContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { [unowned self] (success, evalPolicyError) in
				
				if success {
					
					OperationQueue.main.addOperation({ () -> Void in
						
						self.performSegue(withIdentifier: Define.SeguesConstants.kLoginToHomeVCSegue, sender: self)
					})
				}
				else
				{
					switch (evalPolicyError! as NSError).code
					{
					case LAError.systemCancel.rawValue :
						OperationQueue.main.addOperation({ () -> Void in
							
							Utils.promptMessageOnScreen("Authentication was canceellled by the system", viewContoller: self)
						})
					case LAError.userCancel.rawValue :
						OperationQueue.main.addOperation({ () -> Void in
							
							Utils.promptMessageOnScreen("User cancelled the authentication", viewContoller: self)
						})
					case LAError.userFallback.rawValue :
						OperationQueue.main.addOperation({ () -> Void in
							
							Utils.promptMessageOnScreen("User selected to eneter custom password", viewContoller: self)
						})
						
						OperationQueue.main.addOperation({ () -> Void in
							
							Utils.promptMessageOnScreen("authentication failed", viewContoller: self)
							
						})
						
					default:
						OperationQueue.main.addOperation({ () -> Void in
							Utils.promptMessageOnScreen("authentication failed", viewContoller: self)
						})
					}
				}
			})
		}
			
		else{
			// If the security policy cannot be evaluated then show a short message depending on the error.
			switch error!.code{
				
			case LAError.touchIDNotEnrolled.rawValue:
				OperationQueue.main.addOperation({ () -> Void in
					
					Utils.promptMessageOnScreen("TouchID is not enrolled", viewContoller: self)
				})
				
			case LAError.passcodeNotSet.rawValue:
				
				OperationQueue.main.addOperation({ () -> Void in
					
					Utils.promptMessageOnScreen("A passcode has not been set", viewContoller: self)
				})
			default:
				// The LAError.TouchIDNotAvailable case.
				
				OperationQueue.main.addOperation({ () -> Void in
					
					Utils.promptMessageOnScreen("TouchID not available", viewContoller: self)
				})
			}
			
			OperationQueue.main.addOperation({ () -> Void in
				
				Utils.promptMessageOnScreen(error?.localizedDescription ?? "", viewContoller: self)
			})
			// Show the custom alert view to allow users to enter the password.
		}
		
	}
	
	//MARK: Actions on VC
	@IBAction func authenticationButtonPressed(_ sender: UIButton) {
		
		handleTouch()
	}
	
}

