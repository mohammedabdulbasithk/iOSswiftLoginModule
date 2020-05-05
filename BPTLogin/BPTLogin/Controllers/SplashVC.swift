//
//  SplashVC.swift
//  BPTLogin
//
//  Created by Basith on 21/04/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { //wait for 2 sec
            self.checkLoginStatus()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func checkLoginStatus(){
        if theAppModel.sharedInstance.getisLoggedIn() {
            self.navigationController?.pushViewController(theAppModel.sharedInstance.firtsvc!, animated: true)
        } else {
            self.navigationController?.pushViewController(theAppModel.sharedInstance.loginvc!, animated: true)
        }
    }

}
