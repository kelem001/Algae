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
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Retrieve Managed Context
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let dataLogFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Datalog")
        
        do {
            let datalogs = try managedContext.fetch(dataLogFetch) as? [NSManagedObject]
            
            for datalog in datalogs! {
                // Retrieve date for corrent log
                // Date in format YYYY-MM-DD HH:MM:SS in UTC time zone
                let logDate = datalog.value(forKey: "date")
                
                //Retrieve Record ID for current log
                let logID = datalog.objectID
            }
        } catch {print("Error")}
        
    }
    
}
