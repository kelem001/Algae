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
    
//    var tempDiff: Float?
//    var pav: Float?
//    var lux: Float?
//    var chl: Float?
//    var cyano: Float?
    var id: NSManagedObjectID?
    
    @IBOutlet weak var tempDiffLabel: UILabel!
    @IBOutlet weak var pavLabel: UILabel!
    @IBOutlet weak var luxLabel: UILabel!
    @IBOutlet weak var chlaLabel: UILabel!
    @IBOutlet weak var cyanoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "Datalog")
//        do {
//            let results = try managedContext.fetch(fetchRequest)
        let results = managedContext.object(with: self.id!)
        NSLog("test: \(results)")
//            tempDiffLabel.text = String(describing: self.tempDiff!)
//            pavLabel.text = String(describing: self.pav!)
//            luxLabel.text = String(describing: self.lux!)
//            chlaLabel.text = String(describing: self.chl!)
//            cyanoLabel.text = String(describing: self.cyano!)
            
//        } catch let error as NSError {
//            print ("Could not fetch \(error), \(error.userInfo)")
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


