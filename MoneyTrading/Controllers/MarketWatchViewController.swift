//
//  MarketWatchViewController.swift
//  MoneyTrading
//
//  Created by ANIL KUMAR MEDIKONDA on 04/02/19.
//  Copyright © 2019 ANIL KUMAR MEDIKONDA. All rights reserved.
//

import UIKit
import CoreData

class MarketWatchViewController: UIViewController,didTapCallDelegare {

    
    
@IBOutlet weak var markWatchesTableView:UITableView?
    
    var stocks : [Stock] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.markWatchesTableView?.register(UINib(nibName: "StockTableViewCell", bundle: nil), forCellReuseIdentifier: "StockTableViewCell")
        readJson()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func didTapCall(onCell: StockTableViewCell, withIndex: IndexPath, from: String) {
        print(from)
        // Save data to coredata
        
        let Popup = self.storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController
        let stock = stocks[withIndex.row]

        Popup?.fromVC = from as NSString
        Popup?.stockCurrentPrice = Int(truncating: stock.stockCurrentPrice)
        Popup?.stockExchange = stock.stockExchange as NSString
        Popup?.stockID = stock.stockID
        Popup?.stockName = stock.stockName as NSString
        self.present(Popup!, animated: true, completion: nil)


    }
}

// MARK: -  Tableview Delegate And DataSource Methods

extension MarketWatchViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = markWatchesTableView?.dequeueReusableCell(withIdentifier: "StockTableViewCell", for: indexPath) as! StockTableViewCell
        cell.delegate = self
        let stock = stocks[indexPath.row]
        cell.loadWithData(stock: stock)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
        
        
    }
    
}

// MARK: - Json Fetch
extension MarketWatchViewController {
    
    func readJson() {
        
        // Get url for file
        guard let fileUrl = Bundle.main.url(forResource: "marketwatch", withExtension: "json") else {
            print("File could not be located at the given url")
            return
        }
        
        do {
            // Get data from file
            let data = try Data(contentsOf: fileUrl)
            
            // Decode data to a Dictionary<String, Any> object
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print("Could not cast JSON content as a Dictionary<String, Any>")
                return
            }
            
            // Print result
            print(dictionary)
          getStocksFrom(stocksDic: dictionary)
            
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    func getStocksFrom(stocksDic: [String : Any]) {
        
        let stocksArray = stocksDic["stocks"] as! [Any]
        
        for index in 0...stocksArray.count - 1 {
            var stock = stocksArray[index] as! [String : Any]
            let stockObj = Stock(stockName: stock["name"] as! String, stockID: stock["id"] as! Int, stockExchange: stock["exchange"] as! String, stockCurrentPrice: stock["current_price"] as! NSNumber)
            stocks.append(stockObj)
            
        }
        
        markWatchesTableView?.reloadData()
        

    }
    
    
}

