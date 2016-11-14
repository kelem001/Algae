//
//  RealTableViewController.swift
//  Algae Estimator
//
//  Created by Dominique Tipton on 11/10/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit
import CoreData

class DataSetTableViewController: UITableViewController {
    
    var data: Array<Array<Float>> = []
    
    let headers = ["Total Chl a", "Cyano Chl a"]
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.backgroundColor = UIColor(red:0.28, green:0.31, blue:0.58, alpha:1.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[0].count % 24 - 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let text = "[" + String(describing: indexPath.row * 24) + "]\t\t\t:\t\t\t" + String(describing: data[indexPath.section][indexPath.row * 24])
        
        cell.textLabel?.text = text
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = NSTextAlignment.center
        
//        let width = Int(cell.frame.width)
//        let height = Int(cell.frame.height)
//        
//        let lLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width / 2, height: height))
//        lLabel.text = "[" + String(describing: indexPath.row * 24) + "]"
//        lLabel.textAlignment = NSTextAlignment.center
//        lLabel.textColor = UIColor.white
//        
//        let cLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
//        cLabel.text = ":"
//        cLabel.textAlignment = NSTextAlignment.center
//        cLabel.textColor = UIColor.white
//
//        NSLog("Section = \(indexPath.section) Row = \(indexPath.row) Data = \(data[indexPath.section][indexPath.row * 24])")
//        
//        let rLabel = UILabel(frame: CGRect(x: width / 2, y: 0, width: width / 2, height: height))
//        rLabel.text = String(describing: data[indexPath.section][indexPath.row * 24])
//        rLabel.textAlignment = NSTextAlignment.center
//        rLabel.textColor = UIColor.white
//
//        cell.addSubview(lLabel)
//        cell.addSubview(cLabel)
//        cell.addSubview(rLabel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        
        header.tintColor = UIColor(red:0.28, green:0.31, blue:0.58, alpha:1.0)
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.textAlignment = NSTextAlignment.center
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
}
