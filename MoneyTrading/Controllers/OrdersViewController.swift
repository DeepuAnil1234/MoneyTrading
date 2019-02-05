//
//  OrdersViewController.swift
//  MoneyTrading
//
//  Created by ANIL KUMAR MEDIKONDA on 04/02/19.
//  Copyright © 2019 ANIL KUMAR MEDIKONDA. All rights reserved.
//

import UIKit
import CoreData

class OrdersViewController: UIViewController {

    @IBOutlet weak var segmentControloutlet: UISegmentedControl!
    @IBOutlet weak var tableV: UITableView!
    var entityNameStr = "BUYCD"
    var stocks : [Stock] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Orders"

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableV?.register(UINib(nibName: "StockTableViewCell", bundle: nil), forCellReuseIdentifier: "StockTableViewCell")
        self.FethCoredata()
    }

    @IBAction func segmentControlAction(_ sender: Any) {
        if segmentControloutlet.selectedSegmentIndex == 0{entityNameStr = "BUYCD"}
        else{entityNameStr = "SELLCD"}
        self.FethCoredata()
    }
    
    func FethCoredata() {
        // To fetch data from coredata
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityNameStr)
        request.returnsObjectsAsFaults = false
        stocks = []
        do {
            let result = try context.fetch(request)
            print(result)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "stockName") as! String)
                let stockObj = Stock(stockName: data.value(forKey: "stockName") as! String, stockID: data.value(forKey: "stockID") as! Int, stockExchange: data.value(forKey: "stockExchange") as! String, stockCurrentPrice: data.value(forKey: "stockCurrentPrice") as! NSNumber)
                stocks.append(stockObj)
            }
            print(stocks)
            self.showToast(message : "Fetched Succesfully")
            tableV.reloadData()
        } catch {
            
            print("Failed")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension OrdersViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableV?.dequeueReusableCell(withIdentifier: "StockTableViewCell", for: indexPath) as! StockTableViewCell
        // hide buy and sell in dashboard screen
        cell.buybutton?.isHidden = true
        cell.sellbutton?.isHidden = true
        let stock = stocks[indexPath.row]
        cell.loadWithData(stock: stock)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
        
    }
    
}
