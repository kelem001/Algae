//
//  DataLogViewController.swift
//  Algae Estimator
//
//  Created by Dominique Tipton on 10/21/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit
import CoreData

class DataLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var objects: NSMutableArray! = NSMutableArray()
    
    var datalogs :[NSManagedObject]?
    var datalogIDs: [NSManagedObjectID]?
    var datalogIDsIndex: Int?
    
    override func viewDidLoad() {
        
        // Retrieve Managed Context
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let dataLogFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Datalog")
        
        do {
            let datalogs = try managedContext.fetch(dataLogFetch) as? [NSManagedObject]
            
            //var offset: Int = 30
            
            //let screenSize: CGRect = UIScreen.main.bounds
            //let btnWidth = screenSize.width
            //let btnHeight = 20
            
            //var index = 0
            
            for datalog in datalogs! {
                // Retrieve date for corrent log
                // Date in format YYYY-MM-DD HH:MM:SS in UTC time zone
                let logDate = datalog.value(forKey: "date")
                if (logDate != nil) {
                    let dateStr = String(describing: logDate!)
                    
                    let dateFormatter = DateFormatter()
                    let hourFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    hourFormatter.dateFormat = "HH:mm:ss"
                    let date = dateFormatter.string(from: logDate as! Date)
                    let hour = hourFormatter.string(from: logDate as! Date)

                    // Does not add all dates, also not currently removing all duplicates
                    //if (dateStr.contains(date)) {
                    self.objects.add(date)
                    //}
                    
                    //Retrieve Record ID for current log
                    let logID = datalog.objectID
                    if datalogIDs?.append(logID) == nil {
                        datalogIDs = [logID]
                    }
                    
                    //let button = UIButton(type: .system)
                    //button.frame = CGRect(origin: CGPoint(x: 0,y: offset), size: CGSize(width: CGFloat(btnWidth), height: CGFloat(btnHeight)))
                    //button.backgroundColor = UIColor.green
                    //button.setTitle(date, for: UIControlState.normal)
                    //button.tag = index
                    //button.addTarget(self, action: #selector(DataLogViewController.viewDataLog), for: UIControlEvents.touchUpInside)
                    //self.view.addSubview(button)
                    
                    //offset += btnHeight
                    //index += 1
                }
            }
        } catch {print("Error")}
        self.tableView.reloadData()
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! DataLogTableViewCell
        
        cell.titleLabel.text = self.objects.object(at: indexPath.row) as? String
        
        // Index pass?
        cell.titleLabel.tag = indexPath.row
        
        
        //cell.shareButton.tag = indexPath.row
        
        //cell.shareButton.addTarget(self, action: "sendDataLog", for: .touchUpInside)
        
        return cell
    }
    
    //func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      //  self.performSegue(withIdentifier: "showView", sender: self)
    //}
    
    //@IBAction func logAction(sender: UIButton) {
    //let titleString = self.objects.object(at: sender.tag) as? String
    //let firstActivityItem = "\(titleString!)"
    //let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
    //self.present(activityViewController, animated: true, completion: nil)
    //}
    
    //@IBAction func sendDataLog(sender: UIButton) {
      //  datalogIDsIndex = sender.tag
       // NSLog(String(describing: sender.tag))
       // NSLog(String(describing: datalogIDs))
       // performSegue(withIdentifier: "showView", sender: self)
    //}
    
    // func viewDataLog(sender: UIButton) {
    //   datalogIDsIndex = sender.tag
    // NSLog(String(describing: sender.tag))
    // NSLog(String(describing: datalogIDs))
    // performSegue(withIdentifier: "showLog", sender: self)
    //}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showView") {
            var upcoming: DataLog2ViewController = segue.destination as! DataLog2ViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            let titleString = self.objects.object(at: indexPath.row) as? String
            upcoming.titleString = titleString
            upcoming.datalogIDsIndex = indexPath.row
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        //if (segue.identifier == "showLog") {
        // Obtain destVC controller instance.
        //  let tabbar = segue.destination as! UITabBarController
        // let destinationVC = tabbar.viewControllers?[0] as! DataViewController
        
        // Pass ObjectID to the destVC
        // NSLog(String(describing: datalogIDs?[datalogIDsIndex!]))
        // destinationVC.id = datalogIDs?[datalogIDsIndex!]
        // }
    }
}
