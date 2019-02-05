//
//  Stock.swift
//  MoneyTrading
//
//  Created by ANIL KUMAR MEDIKONDA on 04/02/19.
//  Copyright © 2019 ANIL KUMAR MEDIKONDA. All rights reserved.
//

import Foundation


struct Stock {
    
    var stockName : String
    var stockID : Int
    var stockExchange: String
    var stockCurrentPrice : NSNumber
    
    init(stockName: String,
         stockID:Int,
         stockExchange: String,
         stockCurrentPrice: NSNumber) {
        
        self.stockName = stockName
        self.stockID = stockID
        self.stockExchange = stockExchange
        self.stockCurrentPrice = stockCurrentPrice
        
    }
    
}
