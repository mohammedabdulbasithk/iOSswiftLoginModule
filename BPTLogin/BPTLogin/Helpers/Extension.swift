//
//  Extentions.swift
//  BPTLogin
//
//  Created by Basith on 21/04/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hideActivityIndicator() {
        let activityIndicator = view.viewWithTag(999) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
//        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func showActivityIndicator() { 
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:0.75)
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        activityIndicator.tag = 999
        
        // before adding it, you need to check if it is already has been added:
        for subview in view.subviews {
            if subview.tag == 999 {
                return
            }
        }
        view.addSubview(activityIndicator)
    }
    
    func showErrorMessage(message:String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
