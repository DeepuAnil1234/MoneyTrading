//
//  StockTableViewCell.swift
//  MoneyTrading
//
//  Created by ANIL KUMAR MEDIKONDA on 04/02/19.
//  Copyright © 2019 ANIL KUMAR MEDIKONDA. All rights reserved.
//

import UIKit

protocol didTapCallDelegare {
    func didTapCall(onCell: StockTableViewCell , withIndex: IndexPath , from: String)
}

class StockTableViewCell: UITableViewCell {

    @IBOutlet weak var stockNameLabel : UILabel?
    @IBOutlet weak var stockpriceLabel : UILabel?
    @IBOutlet weak var stockexchangeNameLabel : UILabel?
    @IBOutlet weak var sellbutton : UIButton?
    @IBOutlet weak var buybutton : UIButton?
    var delegate: didTapCallDelegare?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadWithData(stock : Stock) {
        self.stockNameLabel?.text = stock.stockName
        self.stockpriceLabel?.text = "\(stock.stockCurrentPrice)"
        self.stockexchangeNameLabel?.text = stock.stockExchange

    }
    @IBAction func buyBtn(_ sender: Any) {
        delegate?.didTapCall(onCell: self , withIndex: self.getIndexPath()!, from: "BUY")
    }
    @IBAction func sellBtn(_ sender: Any) {
        delegate?.didTapCall(onCell: self , withIndex: self.getIndexPath()!, from: "SELL")
    }
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            print("superview is not a UITableView - getIndexPath")
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath
    }

}
