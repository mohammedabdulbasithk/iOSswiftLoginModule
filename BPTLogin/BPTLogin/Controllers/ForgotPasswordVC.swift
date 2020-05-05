//
//  ForgotPasswordVC.swift
//  BPTLogin
//
//  Created by Basith on 23/04/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    var email : String?
    @IBOutlet weak var emailTextInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func buttonClicked(_ sender: Any) {
        email = emailTextInput.text
        if checkEmpty(email: email!){
            if isValidEmail(testStr: email!){
                theAppModel.sharedInstance.forgotPassword(email: email!){ (forgotCallBack) in
                    if forgotCallBack == true {
                        theAppModel.sharedInstance.showToast(controller: self, message: "Chack your email for OTP", seconds: 1.0)
                        self.navigationController?.pushViewController(theAppModel.sharedInstance.resetpasswordvc!, animated: true)
                    }else{
                        theAppModel.sharedInstance.showToast(controller: self, message: "Cannot find the email", seconds: 1.0)
                    }
                }
            }else{
                theAppModel.sharedInstance.showToast(controller: self, message: "Email not valid", seconds: 1.0)
            }
        }else{
            theAppModel.sharedInstance.showToast(controller: self, message: "Email cant be empty", seconds: 1.0)
        }
    }
    
    func checkEmpty(email:String)->Bool {
        if email.isEmpty {
            return false
        }
        else {
            return true
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
