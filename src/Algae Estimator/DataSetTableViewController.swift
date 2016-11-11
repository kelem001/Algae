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

        let width = Int(cell.frame.width)
        let height = Int(cell.frame.height)
        
        let lLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width / 2, height: height))
        lLabel.text = "[" + String(describing: indexPath.row * 24) + "]"
        lLabel.textAlignment = NSTextAlignment.center
        lLabel.textColor = UIColor.white
        
        let cLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        cLabel.text = ":"
        cLabel.textAlignment = NSTextAlignment.center
        cLabel.textColor = UIColor.white

        NSLog("Section = \(indexPath.section) Row = \(indexPath.row) Data = \(data[indexPath.section][indexPath.row * 24])")
        
        let rLabel = UILabel(frame: CGRect(x: width / 2, y: 0, width: width / 2, height: height))
        rLabel.text = String(describing: data[indexPath.section][indexPath.row * 24])
        rLabel.textAlignment = NSTextAlignment.center
        rLabel.textColor = UIColor.white
        
        cell.addSubview(lLabel)
        cell.addSubview(cLabel)
        cell.addSubview(rLabel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        
        header.tintColor = UIColor(ciColor: CIColor(red: 0x48, green: 0x4E, blue: 0x93))
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.textAlignment = NSTextAlignment.center
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }

}
