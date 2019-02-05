//
//  DashBoardTableViewController.swift
//  MoneyTrading
//
//  Created by ANIL KUMAR MEDIKONDA on 05/02/19.
//  Copyright © 2019 ANIL KUMAR MEDIKONDA. All rights reserved.
//

import UIKit

class DashBoardTableViewController: UITableViewController {

    var dashBoardArray =  ["Profile","Orders"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashBoardArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell")!
        
        cell.textLabel?.text = dashBoardArray[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let signupVc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
            self.navigationController?.pushViewController(signupVc!, animated: true)
            
        }else {
            
            let signupVc = self.storyboard?.instantiateViewController(withIdentifier: "OrdersViewController") as? OrdersViewController
            self.navigationController?.pushViewController(signupVc!, animated: true)
            
        }
        
    }

   
}
