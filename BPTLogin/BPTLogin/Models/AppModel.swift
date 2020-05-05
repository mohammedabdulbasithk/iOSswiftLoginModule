//
//  AppModel.swift
//  BPTLogin
//
//  Created by Basith on 21/04/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import Foundation
import UIKit 


class theAppModel{
    
    static let sharedInstance = theAppModel()
    
    let firtsvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstvc") as? FirstVC
    let splashvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "splashvc") as? SplashVC
    let loginvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginvc") as? LoginVC
    let forgotpasswordvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "forgotpasswordvc") as? ForgotPasswordVC
    let resetpasswordvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "resetpasswordvc") as? ResetPasswordVC
    
    let appurl = AppUrl()
    
    func modelInit(){
        
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    
    func setisLoggedIn(bool:Bool){
        UserDefaults.standard.set(bool,forKey:"isLoggedIn")
        UserDefaults.standard.synchronize()
    }
    
    func getisLoggedIn() -> Bool{
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        return isLoggedIn
    }
    
    func getEmailofUser() -> String{
        let email = UserDefaults.standard.string(forKey: "email")
        return email ?? "Deafault"
    }
    
    func getUserType() -> String{
           let userType = UserDefaults.standard.string(forKey: "userType")
           return userType ?? "Deafault"
    }
    
    
    func login(userName:String, passWord: String, loginCallBack: @escaping (Bool)-> Void)-> Void{
        let loginUrl = appurl.getUrl(endPoint: APP_ENDPOINT_URL.loginRequest)
        let params = ["email": userName, "password": passWord]
        let cloudDatamodel = jsonDomObject(reqUrl: loginUrl)
        cloudDatamodel.sendPostDataToCloud(serviceName: loginUrl, parameters: params) { (result, error) in
            if error == nil && result!["success"] == true{
                loginCallBack(true)
                UserDefaults.standard.set(result!["email"].stringValue, forKey: "email")
                UserDefaults.standard.set(passWord, forKey: "password")
                UserDefaults.standard.set("admin", forKey: "userType")
                UserDefaults.standard.synchronize()
                self.setisLoggedIn(bool: true)
            }
            else {
                print("Login Call back Should false",error as Any)
                loginCallBack(false)
            }
        }
    }
    
    func forgotPassword(email:String, forgotCallBack: @escaping (Bool)-> Void)-> Void{
        let forgotUrl = appurl.getUrl(endPoint: APP_ENDPOINT_URL.forgoPasswordtRequest)
        let params = ["email": email]
        let cloudDatamodel = jsonDomObject(reqUrl: forgotUrl)
        cloudDatamodel.sendPostDataToCloud(serviceName: forgotUrl, parameters: params) { (result, error) in
            if error == nil && result!["success"] == true {
                forgotCallBack(true)
            }
            else {
                print("Request Failed",error as Any)
                forgotCallBack(false)
            }
        }
    }
    
    func changePassword(email:String, password: String, changeCallBack: @escaping (Bool)-> Void)-> Void{
        let forgotUrl = appurl.getUrl(endPoint: APP_ENDPOINT_URL.changePasswordRequest)
        let params = ["email": email, "password": password]
        let cloudDatamodel = jsonDomObject(reqUrl: forgotUrl)
        cloudDatamodel.sendPostDataToCloud(serviceName: forgotUrl, parameters: params) { (result, error) in
            if error == nil && result!["success"] == true {
                changeCallBack(true)
            }
            else {
                print("Request Failed",error as Any)
                changeCallBack(false)
            }
        }
    }
    
}
