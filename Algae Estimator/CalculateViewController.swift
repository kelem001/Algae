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
    
    var po4Est: Float?
    
    //All IBOUTLETS are properties, text boxes are UITextField and
    //UILabel is the results label
    @IBOutlet weak var tempSurface: UITextField!
    @IBOutlet weak var tempBottom: UITextField!
    @IBOutlet weak var tempDiffLabel: UILabel!
    
    
    @IBOutlet weak var brightBox: UITextField!
    @IBOutlet weak var luxLabel: UILabel!
    
    
    @IBAction func po4Set(_ sender: UIButton) {
        performSegue(withIdentifier: "po4TabBar", sender: self)
    }
    
    
    @IBOutlet weak var lakeDepthBox: UITextField!
    @IBOutlet weak var pavLabel: UILabel!
    
    @IBOutlet weak var cyanoChlBox: UITextField!
    
    @IBOutlet weak var chlBox: UITextField!
    @IBOutlet weak var chLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "po4TabBar") {
            
        } else if (segue.identifier == "toDataPage") {
            
            // Get input values from View.
            let temp_diff = Float(tempSurface.text!)! - Float(tempBottom.text!)!
            let brightness = Float(brightBox.text!)!
            let po4 = po4Est! / Float(lakeDepthBox.text!)!
            let total_chl = Float(chlBox.text!)!
            let cyano_chl = Float(cyanoChlBox.text!)!
            let depth = Float(lakeDepthBox.text!)!
            let date = NSDate()
            
            // Retrieve PersistentContainer managed Context...
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            // Retrieve Datalog entity from CoreData model.
            let entity = NSEntityDescription.entity(forEntityName: "Datalog", in: managedContext)
            let datalog = NSManagedObject(entity: entity!, insertInto: managedContext)
            
            // Insert form data into CoreData model
            datalog.setValue(temp_diff, forKey: "temp_diff")
            datalog.setValue(brightness, forKey: "brightness")
            datalog.setValue(po4, forKey: "po4")
            datalog.setValue(total_chl, forKey: "total_chl")
            datalog.setValue(cyano_chl, forKey: "cyano_chl")
            datalog.setValue(depth, forKey: "depth")
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

