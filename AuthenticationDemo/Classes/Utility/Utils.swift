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
		alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment:""), style: UIAlertActionStyle.default, handler:nil))
		viewContoller.present(alert, animated:true, completion:nil)
	}
}


