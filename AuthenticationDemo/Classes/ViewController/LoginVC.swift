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
		title = NSLocalizedString("Login", comment: "")
		
		// authentication button appearances
		self.authenticationButton.backgroundColor = Define.ColorConstants.kAppMainColor
		self.authenticationButton.tintColor = Define.ColorConstants.kBaseColor
	}
	
	//MARK: Private methods
	func manageTouch(){
		
		let laContext = LAContext()
		var error : NSError? = nil
		let reasonString = NSLocalizedString("Authentication is required for you to use this application", comment: "")
		
		if  laContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
		{
			laContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { [unowned self] (success, evalPolicyError) in
				
				// if fingerprints successfully recognised move to HOME page
				if success {
					
					OperationQueue.main.addOperation({ () -> Void in
						
						self.performSegue(withIdentifier: Define.SeguesConstants.kLoginToHomeVCSegue, sender: self)
					})
				}
					
				//if failed to recognised fingerprints
				else
				{
					self.hangleInvalidTouch(_error: evalPolicyError!)
				}
			})
		}
		 // if touch sensor has any issue
		else{
			self.handleTouchIssues(_error: error!)
		}
	}
	
	//method fetches reason if failed to recognised fingerprints
	func hangleInvalidTouch(_error evalPolicyError:Error){
		
		switch (evalPolicyError as NSError).code
		{
		case LAError.systemCancel.rawValue :
			OperationQueue.main.addOperation({ () -> Void in
				
				Utils.promptMessageOnScreen(NSLocalizedString("Authentication was canceellled by the system", comment: ""), viewContoller: self)
			})
		case LAError.userCancel.rawValue :
			OperationQueue.main.addOperation({ () -> Void in
				
				Utils.promptMessageOnScreen(NSLocalizedString("User cancelled the authentication", comment: ""), viewContoller: self)
			})
		case LAError.userFallback.rawValue :
			OperationQueue.main.addOperation({ () -> Void in
				
				Utils.promptMessageOnScreen(NSLocalizedString("User selected to eneter custom password", comment: ""), viewContoller: self)
			})
			
			OperationQueue.main.addOperation({ () -> Void in
				
				Utils.promptMessageOnScreen(NSLocalizedString("authentication failed", comment: ""), viewContoller: self)
				
			})
			
		default:
			OperationQueue.main.addOperation({ () -> Void in
				Utils.promptMessageOnScreen(NSLocalizedString("authentication failed", comment: ""), viewContoller: self)
			})
		}
	}
	
	// If the security policy cannot be evaluated then show a short message depending on the error.
	func handleTouchIssues(_error error:NSError){
		
		switch error.code{
			
		case LAError.touchIDNotEnrolled.rawValue:
			OperationQueue.main.addOperation({ () -> Void in
				
				Utils.promptMessageOnScreen(NSLocalizedString("TouchID is not enrolled", comment: ""), viewContoller: self)
			})
			
		case LAError.passcodeNotSet.rawValue:
			
			OperationQueue.main.addOperation({ () -> Void in
				
				Utils.promptMessageOnScreen(NSLocalizedString("A passcode has not been set", comment: ""), viewContoller: self)
			})
		default:
			
			// The LAError.TouchIDNotAvailable case.
			OperationQueue.main.addOperation({ () -> Void in
				
				Utils.promptMessageOnScreen(NSLocalizedString("TouchID not available", comment: ""), viewContoller: self)
			})
		}
		
		OperationQueue.main.addOperation({ () -> Void in
			
			Utils.promptMessageOnScreen(error.localizedDescription , viewContoller: self)
		})
		// Show the custom alert view to allow users to enter the password.
	}
	
	
	//MARK: Actions on VC
	@IBAction func authenticationButtonPressed(_ sender: UIButton) {
		
		manageTouch()
	}
}

