//
//  Utility.swift
//  MoneyTrading
//
//  Created by Ink-In-Caps on 05/02/19.
//  Copyright © 2019 ANIL KUMAR MEDIKONDA. All rights reserved.
//



import UIKit
import Foundation

class Utility {
    static func infoAlertWithoutMessage(_ title:String,viewController:UIViewController) -> Void {
        let actionSheetController: UIAlertController = UIAlertController(title:title, message:nil, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title:"OK" , style: .cancel)
        actionSheetController.addAction(cancelAction)
        viewController.present(actionSheetController, animated: true, completion: nil)
    }
    static func infoAlertWithMessage(_ title:String, message:String,viewController:UIViewController) -> Void {
        let actionSheetController: UIAlertController = UIAlertController(title:title, message:message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title:"OK" , style: .cancel) { action -> Void in }
        actionSheetController.addAction(cancelAction)
        viewController.present(actionSheetController, animated: true, completion: nil)
    }
}

extension UITextField {
    
    func useUnderline() {
        
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
