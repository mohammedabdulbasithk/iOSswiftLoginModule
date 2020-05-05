//
//  LoginVC.swift
//  BPTLogin
//
//  Created by Basith on 21/04/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    var email : String = ""
    var password : String = ""
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        email = self.emailTextField.text!
        password = self.passwordTextField.text!
        
        if checkEmpty(email: email, password: password) {
            tryLogin(email: email, password: password)
        }else{
            print("Email and password cant be empty")
        }
        
    }
    
    func checkEmpty(email:String,password:String)->Bool {
        if email.isEmpty || password.isEmpty {
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
    
    func tryLogin(email :String,password :String) {
        if isValidEmail(testStr: email) {
            self.showActivityIndicator()
            theAppModel.sharedInstance.login(userName: email, passWord: password) { (loginResult) in
                print("Info  - loginResult Closure ",loginResult)
                if loginResult == true {
                    self.hideActivityIndicator()
                    self.goToFirstPage()
                }
                else {
                    theAppModel.sharedInstance.showToast(controller: self, message: "Login Failed!", seconds: 2.0)
                    self.hideActivityIndicator()
                }
            }
        }
        else {
            theAppModel.sharedInstance.showToast(controller: self, message: "Invalid Email", seconds: 2.0)
        }
        
    }
    
    func goToFirstPage(){
        self.navigationController?.pushViewController(theAppModel.sharedInstance.firtsvc!, animated: true)
    }
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        self.navigationController?.pushViewController(theAppModel.sharedInstance.forgotpasswordvc!, animated: true)
    }
    
}


