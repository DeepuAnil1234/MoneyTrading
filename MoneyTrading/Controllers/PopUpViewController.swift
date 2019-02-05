//
//  PopUpViewController.swift
//  MoneyTrading
//
//  Created by Sandeep Thakur on 05/02/19.
//  Copyright © 2019 ANIL KUMAR MEDIKONDA. All rights reserved.
//

import UIKit
import CoreData

class PopUpViewController: UIViewController {

    var fromVC = NSString()
    var stockCurrentPrice = Int()
    var stockExchange = NSString()
    var stockID = Int()
    var stockName = NSString()
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var priceTF: RKYUITextField!
    
    @IBOutlet weak var quantityTF: RKYUITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleLab.text = "\(fromVC )"
        priceTF.text = "\(stockCurrentPrice)"
        
        // Do any additional setup after loading the view.
    }
    @IBAction func savebtn(_ sender: Any) {
        if quantityTF.text == "" {
            self.showToast(message : "Please Enter Quantity")

        }
        else{
            
           self.SaveData()
        }
        
        
        
    }
    
    func SaveData(){
        
        print(fromVC)
        // Save data to coredata
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if fromVC == "BUY" {
            
            let price = Int(priceTF.text! as! String)
            print(price as Any)
            
            
            let entity = NSEntityDescription.entity(forEntityName: "BUYCD", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            newUser.setValue(price , forKey: "stockCurrentPrice") // int
            
            newUser.setValue(self.stockExchange, forKey: "stockExchange") // str
            newUser.setValue(self.stockID, forKey: "stockID") // int
            newUser.setValue(self.stockName, forKey: "stockName") // str quantity
            newUser.setValue(quantityTF.text , forKey: "quantity") // int

        }
        else{
            
            let price = Int(priceTF.text! as! String)
            print(price as Any)
            
            let entity = NSEntityDescription.entity(forEntityName: "SELLCD", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            newUser.setValue(price , forKey: "stockCurrentPrice") // int number
            newUser.setValue(self.stockExchange, forKey: "stockExchange") // str
            newUser.setValue(self.stockID, forKey: "stockID") // int
            newUser.setValue(self.stockName, forKey: "stockName") // str
            newUser.setValue(quantityTF.text , forKey: "quantity") // int

        }
        
        do {
            try context.save()
            self.showToast(message : "Saved Succesfully")
            self.dismiss(animated: true, completion: nil)
            
        } catch {
            print("Failed saving")
        }
        
    }

  

}
