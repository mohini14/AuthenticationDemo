//
//  Utils.swift
//  NotesApplication
//
//  Created by Mohini Sindhu  on 21/07/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

import UIKit

class Utils: NSObject
{

	class func promptMessageOnScreen (_ message : String, viewContoller: UIViewController) -> ()
	{
	
		let alert = UIAlertController(title: NSLocalizedString("Alert", comment: "") ,message: message , preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler:nil))
		viewContoller.present(alert, animated:true, completion:nil)
	}
	
	class func alertPopUpWithTextField(_ message: String, forView view:UIViewController, withBlock handler:@escaping ((String)-> Void)) -> Void
	{
		var textField : UITextField?
		let alert = UIAlertController(title: "Alert", message:message, preferredStyle: UIAlertControllerStyle.alert)
		
		// add textfield
		alert.addTextField { (blockTextField:UITextField) in
			textField?.placeholder = "Enter text"
			textField = blockTextField
		}
		
		// cancel action
		alert.addAction(UIAlertAction(title: "close", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
			alert.removeFromParentViewController()
		}))
		
		// Save action

		alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
			
			if (textField?.text?.isEmpty)!
			{
				Utils.promptMessageOnScreen("empty field", viewContoller: view)
			}
			
			else
			{
			   handler((textField?.text)!)
			}
		}))
		
		
		view.present(alert, animated: true, completion:nil)
	}
}


