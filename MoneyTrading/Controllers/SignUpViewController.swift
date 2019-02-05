//
//  SignUpViewController.swift
//  MoneyTrading
//
//  Created by Ink-In-Caps on 05/02/19.
//  Copyright © 2019 ANIL KUMAR MEDIKONDA. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak  var fullNameTextfield: UITextField!
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var emailIdTextfield: UITextField!
    @IBOutlet weak var mobileNumberTextfield: UITextField!
    @IBOutlet weak  var passwordTextfield: UITextField!
    @IBOutlet weak var addresstexfiled : UITextField!
    @IBOutlet weak var reEnterPasswordTextfield: UITextField!
    @IBOutlet weak var termsAndConChkMark: UIImageView!
    @IBOutlet weak var cornerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func termsAndConBtnAct(_ sender: AnyObject)
    {
        
        if termsAndConChkMark.image == UIImage.init(named:"icons8-checkmark-30" as String)
        {
            termsAndConChkMark.image =  UIImage.init(named:"" as String)
            termsAndConChkMark.isHidden = true
            cornerView.isHidden = false
        }
            
        else
        {
            
            termsAndConChkMark.image =  UIImage.init(named:"icons8-checkmark-30" as String)
            termsAndConChkMark.isHidden = false
            cornerView.isHidden = false
            
        }
    }
    
    @IBAction func backAcction(_ sender: AnyObject){
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    @IBAction func nextAction(_ sender: AnyObject){
        
        
        let tabbar = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as? TabViewController
        self.navigationController?.pushViewController(tabbar!, animated: true)

        
        
    }
    
    // Mark Validation Methods
    
    func checkvalidations()->Bool  {
        
        
        
        if  (fullNameTextfield.text?.isEmpty)! {
            
            Utility.infoAlertWithMessage("Error", message: "please Enter The FullNameText", viewController: self )
            
        } else if (userNameTextfield.text?.isEmpty)! {
            
            Utility.infoAlertWithMessage("Error", message: "please Enter The UserNameText", viewController: self )
            
            
        } else if (emailIdTextfield.text?.isEmpty)! {
            
            Utility.infoAlertWithMessage("Error", message: "please Enter The Email-Id", viewController: self )
            
            
        }else if (!emailIdTextfield.text!.isEmpty) {
            
            if self.emailValidation((emailIdTextfield?.text)!) {
                
            }  else {
                
                Utility.infoAlertWithMessage("Error", message: "please Enter The  Vaild Email-Id", viewController: self )
            }
            
        } else if (mobileNumberTextfield.text?.isEmpty)! {
            
            
            Utility.infoAlertWithMessage("Error", message: "please Enter The MobileNuber", viewController: self )
            
        }else if (!mobileNumberTextfield.text!.isEmpty) {
            
            if self.emailValidation((emailIdTextfield?.text)!) {
                
            }  else {
                
                Utility.infoAlertWithMessage("Error", message: "please Enter The valid Mobile Number", viewController: self )
            }
            
        }
        else if (addresstexfiled.text?.isEmpty)! {
            
            Utility.infoAlertWithMessage("Error", message: "please Enter The Addres", viewController: self )
            
            
        }else if (passwordTextfield.text?.isEmpty)! {
            
            Utility.infoAlertWithMessage("Error", message: "please Enter The Password", viewController: self )
            
        }
            
        else if (reEnterPasswordTextfield.text?.isEmpty)! {
            
            Utility.infoAlertWithMessage("Error", message: "please Enter The Password", viewController: self )
            
            
        } else if (passwordTextfield.text! != reEnterPasswordTextfield.text)  {
            
            Utility.infoAlertWithMessage("Error", message: "please Enter The Above password", viewController: self )
            
        } else if termsAndConChkMark.image == nil {
            
            Utility.infoAlertWithMessage("Error", message: "please  Check The Terms And Conditions", viewController: self )
            
        }else {
            
            Utility.infoAlertWithMessage("Ok", message: " its sucessFullly", viewController: self )
            
        }
        
        return true
        
    }
    
    
    //MARK:-  Email And Mobile Number Validations Methods
    
    func emailValidation(_ emailId: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        
        if  emailIdTextfield?.text!.characters.count == 0 {
            
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
        
        
        if  mobileNumberTextfield?.text!.characters.count == 0 {
            
            Utility.infoAlertWithMessage("Error", message: "please Enter The email-Id", viewController: self )
            
        }
        
        
        if validate(value: PHONE_REGEX) {
            
            return  true;
            
        }else {
            
            Utility.infoAlertWithMessage("Error", message: "please Enter The  Vaild Email-Id", viewController: self )
            
        }
        
        return result
        
        
    }
    
    //MARK:- keyBoardHidden Methods
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}



