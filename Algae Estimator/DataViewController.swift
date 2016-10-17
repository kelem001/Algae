//
//  DataViewController.swift
//  Algae Estimator
//
//  Created by MichaelHorning on 10/5/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit
import CoreData

class DataViewController: UIViewController {

    // ID for the target NSManagedObject for datalog.
    var id: NSManagedObjectID?
    
    @IBOutlet weak var tempDiffLabel: UILabel!
    @IBOutlet weak var pavLabel: UILabel!
    @IBOutlet weak var luxLabel: UILabel!
    @IBOutlet weak var chlaLabel: UILabel!
    @IBOutlet weak var cyanoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve Managed Context
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Retrieve target datalog based on NSManagedObjectID
        let datalog = managedContext.object(with: self.id!)
        
        
        // Set Data label values, set them to 'Not Found' if the corresponding value doesn't exist.
        if let tempDiff = datalog.value(forKey: "temp_diff") {
            tempDiffLabel.text = String(describing: tempDiff)
        } else {
            tempDiffLabel.text = "Not Found"
        }
        
        if let po4 = datalog.value(forKey: "po4") {
            pavLabel.text = String(describing: po4)
        } else {
            pavLabel.text = "Not Found"
        }

        if let lux = datalog.value(forKey: "brightness") {
            luxLabel.text = String(describing: lux)
        } else {
            luxLabel.text = "Not Found"
        }
        
        if let total_chl = datalog.value(forKey: "total_chl") {
            chlaLabel.text = String(describing: total_chl)
        } else {
            chlaLabel.text = "Not Found"
        }
        
        if let cyano_chl = datalog.value(forKey: "cyano_chl") {
            cyanoLabel.text = String(describing: cyano_chl)
        } else {
            cyanoLabel.text = "Not Found"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


