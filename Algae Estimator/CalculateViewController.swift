//
//  ViewController.swift
//  Algae Estimator
//
//  Created by App Factory on 9/30/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit
import CoreData

class CalculateViewController: UIViewController {
    
    var dataEntryVals: [String:Float] = [:]
    
    var po4Est: Float?
    
    var totalChl: Float?
    var cyannoChl: Float?
    
    var secciDepth: Float?
    var dissolvedOxygen: Float?
    
    //All IBOUTLETS are properties, text boxes are UITextField and
    //UILabel is the results label
    
    @IBOutlet weak var tempSurface: UITextField!
    @IBOutlet weak var tempBottom: UITextField!
    //@IBOutlet weak var tempDiffLabel: UILabel!
    
    
    @IBOutlet weak var brightBox: UITextField!
    //@IBOutlet weak var luxLabel: UILabel!
    
    
    @IBAction func po4Set(_ sender: UIButton) {
        performSegue(withIdentifier: "po4TabBar", sender: self)
    }
    
    
    @IBOutlet weak var lakeDepthBox: UITextField!
    //@IBOutlet weak var pavLabel: UILabel!
    
    @IBOutlet weak var cyanoChlBox: UITextField!
    
    @IBOutlet weak var chlBox: UITextField!
    //@IBOutlet weak var chLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if dataEntryVals["temp_top"] != nil {
            tempSurface.text = String(describing: dataEntryVals["temp_top"]!)
        }
        if dataEntryVals["temp_bot"] != nil {
            tempBottom.text = String(describing: dataEntryVals["temp_bot"]!)
        }
        if dataEntryVals["brightness"] != nil {
            brightBox.text = String(describing: dataEntryVals["brightness"]!)
        }
        if dataEntryVals["depth"] != nil {
            lakeDepthBox.text = String(describing: dataEntryVals["depth"]!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (tempBottom.text != "") {
            dataEntryVals["temp_bot"] = Float(tempBottom.text!)!
        }
        if (tempSurface.text != "") {
            dataEntryVals["temp_top"] = Float(tempSurface.text!)!
        }
        if (brightBox.text != "") {
            dataEntryVals["brightness"] = Float(brightBox.text!)!
        }
        if (lakeDepthBox.text != "") {
            dataEntryVals["depth"] = Float(lakeDepthBox.text!)!
        }
        
        if (segue.identifier == "po4TabBar") {
            
            // Obtain destVC controller instance.
            let tabbar = segue.destination as! UITabBarController
            let destinationVC = tabbar.viewControllers?[0] as! PO4ViewController
            
            destinationVC.dataEntryVals = dataEntryVals
            
        } else if (segue.identifier == "toChl") {
            
            // Obtain destVC controller instance.
            let tabbar = segue.destination as! UITabBarController
            let destinationVC = tabbar.viewControllers?[0] as! ChlViewController
            let otherTabVC = tabbar.viewControllers?[1] as! ChlEstimateViewController
            
            destinationVC.dataEntryVals = dataEntryVals
            otherTabVC.dataEntryVals = dataEntryVals
            
        } else if (segue.identifier == "toDataPage") {
            
            let date = NSDate()
            
            // Retrieve PersistentContainer managed Context...
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            // Retrieve Datalog entity from CoreData model.
            let entity = NSEntityDescription.entity(forEntityName: "Datalog", in: managedContext)
            let datalog = NSManagedObject(entity: entity!, insertInto: managedContext)
            
            // Insert form data into CoreData model
            datalog.setValue(dataEntryVals["temp_top"], forKey: "temp_top")
            datalog.setValue(dataEntryVals["temp_bot"], forKey: "temp_bot")
            datalog.setValue(dataEntryVals["brightness"], forKey: "brightness")
            datalog.setValue(dataEntryVals["po4"], forKey: "po4")
            
            if dataEntryVals["totalChl"] != nil && dataEntryVals["cyanoChl"] != nil {
                datalog.setValue(dataEntryVals["totalChl"], forKey: "total_chl")
                datalog.setValue(dataEntryVals["cyanoChl"], forKey: "cyano_chl")
            } else {
                datalog.setValue(dataEntryVals["secciDepth"], forKey: "secci_depth")
                datalog.setValue(dataEntryVals["dissolvedOxygen"], forKey: "dissolved_oxygen")
                datalog.setValue(nil, forKey: "total_chl")
            }
            
            datalog.setValue(dataEntryVals["depth"], forKey: "depth")
            datalog.setValue(date, forKey: "date")
            
            do {
                // Commit Changes to database.
                try managedContext.save()
                
                // Get the NSManagedObjectID for the record just inserted.
                let id = datalog.objectID
                
                // Obtain destVC controller instance.
                let tabbar = segue.destination as! UITabBarController
                let destinationVC = tabbar.viewControllers?[0] as! DataViewController
                
                // Pass ObjectID to the destVC
                destinationVC.id = id
            } catch let error as NSError {
                print ("Could not save \(error), \(error.userInfo)")
            }

        }
    }
    
    
    
}

