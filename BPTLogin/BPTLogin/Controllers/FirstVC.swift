//
//  FirstVC.swift
//  BPTLogin
//
//  Created by Basith on 21/04/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = theAppModel.sharedInstance.getEmailofUser()
        
    }
    @IBAction func logoutButtonCLicked(_ sender: Any) {
        logout()
    }
    
    func logout(){
        theAppModel.sharedInstance.setisLoggedIn(bool: false)
        self.navigationController?.popViewController(animated: true)
//        self.navigationController?.pushViewController(theAppModel.sharedInstance.loginvc!, animated: true)
    }
}
