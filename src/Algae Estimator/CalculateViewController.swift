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
    @IBAction func chlValueButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 1
        _updateDataEntryVals()
        result.dataEntryVals = dataEntryVals
        self.present(result, animated: true, completion: nil)
    }
    
    @IBAction func BrightnessButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 2
        _updateDataEntryVals()
        result.dataEntryVals = dataEntryVals
        self.present(result, animated: true, completion: nil)
    }
    @IBAction func lakeDepthButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 3
        _updateDataEntryVals()
        result.dataEntryVals = dataEntryVals
        self.present(result, animated: true, completion: nil)
    }

    @IBAction func TempBotButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 4
        _updateDataEntryVals()
        result.dataEntryVals = dataEntryVals
        self.present(result, animated: true, completion: nil)
    }

    @IBAction func TempSurButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 5
        _updateDataEntryVals()
        result.dataEntryVals = dataEntryVals
        self.present(result, animated: true, completion: nil)
    }
    
    @IBAction func PO4ConButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 6
        _updateDataEntryVals()
        result.dataEntryVals = dataEntryVals
        self.present(result, animated: true, completion: nil)
    }
    
    @IBAction func ChlButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 1
        _updateDataEntryVals()
        result.dataEntryVals = dataEntryVals
        self.present(result, animated: true, completion: nil)
    }
 
    var dataEntryVals: [String:Float] = [:]
    var logID: NSManagedObjectID?
    var logDate: NSDate?
        
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.logID != nil {
            // Retrieve Managed Context
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            // Retrieve target datalog based on NSManagedObjectID
            let datalog = managedContext.object(with: self.logID!)
            
            dataEntryVals["po4"] = datalog.value(forKey: "po4") as! Float
            dataEntryVals["temp_top"] = datalog.value(forKey: "temp_top") as? Float
            dataEntryVals["temp_bot"] = datalog.value(forKey: "temp_bot") as? Float
            dataEntryVals["depth"] = datalog.value(forKey: "depth") as? Float
            dataEntryVals["brightness"] = datalog.value(forKey: "brightness") as? Float
            logDate = datalog.value(forKey: "date") as? NSDate
            
            if (datalog.value(forKey: "total_chl") != nil) {
                dataEntryVals["totalChl"] = datalog.value(forKey: "total_chl") as! Float
                dataEntryVals["cyanoChl"] = datalog.value(forKey: "cyano_chl") as! Float
            } else {
                dataEntryVals["secciDepth"] = datalog.value(forKey: "secci_depth") as! Float
                dataEntryVals["dissolvedOxygen"] = datalog.value(forKey: "dissolved_oxygen") as! Float
            }
        }
        
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
    
    
    private func _updateDataEntryVals() {
        
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
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        _updateDataEntryVals()
        
        
        
        if (segue.identifier == "po4TabBar") {
            
            // Obtain destVC controller instance.
            let tabbar = segue.destination as! UITabBarController
            let destinationVC = tabbar.viewControllers?[0] as! PO4ViewController
            
            destinationVC.dataEntryVals = dataEntryVals
            if logID != nil {
                destinationVC.logID = logID
            }
            
        } else if (segue.identifier == "toChl") {
            
            // Obtain destVC controller instance.
            let tabbar = segue.destination as! UITabBarController
            let destinationVC = tabbar.viewControllers?[0] as! ChlViewController
            let otherTabVC = tabbar.viewControllers?[1] as! ChlEstimateViewController
            
            destinationVC.dataEntryVals = dataEntryVals
            otherTabVC.dataEntryVals = dataEntryVals
            if logID != nil {
                destinationVC.logID = logID
                otherTabVC.logID = logID
            }
        } else if (segue.identifier == "toDataPage") {
            
            let date = NSDate()
            
            // Retrieve PersistentContainer managed Context...
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let datalog: NSManagedObject
            if logID != nil {
                // Retrieve target datalog based on NSManagedObjectID
                datalog = managedContext.object(with: self.logID!)
            } else {
                // Retrieve Datalog entity from CoreData model.
                let entity = NSEntityDescription.entity(forEntityName: "Datalog", in: managedContext)
                datalog = NSManagedObject(entity: entity!, insertInto: managedContext)
            }
            
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
            
            if logID == nil {
                datalog.setValue(date, forKey: "date")
            }

            
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

