//
//  ResetPasswordVC.swift
//  BPTLogin
//
//  Created by Basith on 23/04/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    var otp: String?
    var password: String?
    var email = "email@email.com"
    @IBOutlet weak var otpTextFiels: UITextField!
    @IBOutlet weak var password1: UITextField!
    @IBOutlet weak var password2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func checkEmpty(otp:String,pass1: String, pass2: String)->Bool {
        if otp.isEmpty || pass1.isEmpty || pass2.isEmpty {
            return false
        }
        else {
            return true
        }
    }

    @IBAction func resetClicked(_ sender: Any) {
        if checkEmpty(otp: otpTextFiels.text!, pass1: password1.text!, pass2: password2.text!){
            if password1.text! == password2.text! {
                password = password2.text!
                theAppModel.sharedInstance.changePassword(email: email, password: password!){ (changeCallBack) in
                    if changeCallBack ==  true{
                        theAppModel.sharedInstance.showToast(controller: self, message: "Password changed", seconds: 2.0)
                        self.navigationController?.pushViewController(theAppModel.sharedInstance.loginvc!, animated: true)
                    }else {
                        theAppModel.sharedInstance.showToast(controller: self, message: "check details again", seconds: 2.0)
                    }
                } 
            }else{
                 theAppModel.sharedInstance.showToast(controller: self, message: "Password not matching", seconds: 2.0)
            }
        }else{
            theAppModel.sharedInstance.showToast(controller: self, message: "All fields should be filled", seconds: 2.0)
        }
    }
}
