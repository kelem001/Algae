//
//  DataLogViewController.swift
//  Algae Estimator
//
//  Created by Dominique Tipton on 10/21/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit
import CoreData

class DataLogViewController: UIViewController {

    var datalogs :[NSManagedObject]?
    var datalogIDs: [NSManagedObjectID]?
    var datalogIDsIndex: Int?
    
    func viewDataLog(sender:UIButton) {
        datalogIDsIndex = sender.tag
        NSLog(String(describing: sender.tag))
        NSLog(String(describing: datalogIDs))
        performSegue(withIdentifier: "showLog", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Retrieve Managed Context
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let dataLogFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Datalog")
        
        do {
            let datalogs = try managedContext.fetch(dataLogFetch) as? [NSManagedObject]
            
            var offset: Int = 30
            
            let screenSize: CGRect = UIScreen.main.bounds
            let btnWidth = screenSize.width
            let btnHeight = 20
            
            var index = 0
            
            for datalog in datalogs! {
                // Retrieve date for corrent log
                // Date in format YYYY-MM-DD HH:MM:SS in UTC time zone
                let logDate = datalog.value(forKey: "date")
                if logDate != nil {
                    let dateStr = String(describing: logDate!)
                                
                let dateFormatter = DateFormatter()
                //dateFormatter.dateStyle = .short
                //dateFormatter.timeStyle = .short
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.date(from: dateStr)
                //print(date) //contains nil
                
                //Retrieve Record ID for current log
                let logID = datalog.objectID
                if datalogIDs?.append(logID) == nil {
                    datalogIDs = [logID]
                }
                
                let button = UIButton(type: .system)
                button.frame = CGRect(origin: CGPoint(x: 0,y: offset), size: CGSize(width: CGFloat(btnWidth), height: CGFloat(btnHeight)))
                button.backgroundColor = UIColor.green
                button.setTitle(dateStr, for: UIControlState.normal)
                button.tag = index
                button.addTarget(self, action: #selector(DataLogViewController.viewDataLog), for: UIControlEvents.touchUpInside)
                self.view.addSubview(button)
                
                offset += btnHeight
                index += 1
                }
            }
        } catch {print("Error")}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showLog") {
            // Obtain destVC controller instance.
            let tabbar = segue.destination as! UITabBarController
            let destinationVC = tabbar.viewControllers?[0] as! DataViewController
            
            // Pass ObjectID to the destVC
            NSLog(String(describing: datalogIDs?[datalogIDsIndex!]))
            destinationVC.id = datalogIDs?[datalogIDsIndex!]
        }
    }
}
