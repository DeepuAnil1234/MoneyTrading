//
//  LoginViewController.swift
//  MoneyTrading
//
//  Created by ANIL KUMAR MEDIKONDA on 04/02/19.
//  Copyright © 2019 ANIL KUMAR MEDIKONDA. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var  emailIdText: UITextField?
    @IBOutlet weak var  passwordText : UITextField?
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    
    // MARK: - IBActions
    
    @IBAction func  loginAction() {
        
        
         self.checkvalidations( )
        
        
    }
    
    
    
    //MARK:-  Validations Methods
    func checkvalidations()  {
        
        self.emailValidation((emailIdText?.text)!)
        
        if  (emailIdText?.text?.isEmpty)! {

            Utility.infoAlertWithMessage("Error", message: "please Enter The Email-id", viewController: self )

        } else if (passwordText?.text?.isEmpty)! {

            Utility.infoAlertWithMessage("Error", message: "please Enter The Password", viewController: self )

        } else {

            let tabbar = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as? TabViewController
            self.navigationController?.pushViewController(tabbar!, animated: true)

        }

        
                
    }
    
    
    //MARK:-  Email  And MobileNumber Validations Methods
    
    func emailValidation(_ emailId: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        
        if  emailIdText?.text?.count == 0 {
            
            Utility.infoAlertWithMessage("Error", message: "please Enter The email-Id", viewController: self )
            
        }
        
        if emailTest.evaluate(with: emailId) {
            
            return  true;

        }else {
            
            Utility.infoAlertWithMessage("Error", message: "please Enter The  Vaild Email-Id", viewController: self )

        }
        
        return emailTest.evaluate(with: emailId)
    }
    
    func validate(value: String) -> Bool {
        
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        
        
        return result
        
        
    }
    
    

}
