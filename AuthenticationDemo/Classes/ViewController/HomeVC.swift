//
//  HomeVC.swift
//  AuthenticationDemo
//
//  Created by Mohini Sindhu  on 28/07/17.
//  Copyright © 2017 Mohini Sindhu . All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

	//MARK: View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
		title = NSLocalizedString("Welcome to home", comment: "")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
