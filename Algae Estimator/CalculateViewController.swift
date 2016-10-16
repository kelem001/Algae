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
    
    //All IBOUTLETS are properties, text boxes are UITextField and
    //UILabel is the results label
    @IBOutlet weak var tempSurface: UITextField!
    @IBOutlet weak var tempBottom: UITextField!
    @IBOutlet weak var tempDiffLabel: UILabel!
    
    
    @IBOutlet weak var brightBox: UITextField!
    @IBOutlet weak var luxLabel: UILabel!
    
    
    @IBOutlet weak var po4Box: UITextField!
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
    
    //    @IBAction func saveData(_ sender: AnyObject) {
    //        // Get input values from View.
    //        let temp_diff = Float(tempSurface.text!)! - Float(tempBottom.text!)!
    //        let brightness = Float(brightBox.text!)!
    //        let po4 = Float(po4Box.text!)! / Float(lakeDepthBox.text!)!
    //        let total_chl = Float(chlBox.text!)!
    //        let cyano_chl = Float(cyanoChlBox.text!)!
    //        let depth = Float(lakeDepthBox.text!)!
    //
    //        // Retrieve PersistentContainer managed Context...
    //        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //
    //        // Retrieve Datalog entity from CoreData model.
    //        let entity = NSEntityDescription.entity(forEntityName: "Datalog", in: managedContext)
    //        let datalog = NSManagedObject(entity: entity!, insertInto: managedContext)
    //
    //        // Insert form data into CoreData model
    //        datalog.setValue(temp_diff, forKey: "temp_diff")
    //        datalog.setValue(brightness, forKey: "brightness")
    //        datalog.setValue(po4, forKey: "po4")
    //        datalog.setValue(total_chl, forKey: "total_chl")
    //        datalog.setValue(cyano_chl, forKey: "cyano_chl")
    //        datalog.setValue(depth, forKey: "depth")
    //
    //        // Save data.
    //        do {
    //            try managedContext.save()
    //            let id = datalog.objectID
    //            //            UserDefaults.standard.set(string, forKey: "userID")
    //            NSLog("ID: \(id)")
    //            managedContext.object(with: id)
    //        } catch let error as NSError {
    //            print ("Could not save \(error), \(error.userInfo)")
    //        }
    //    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        //        // Get input values from View.
        //        let temp_diff = Float(tempSurface.text!)! - Float(tempBottom.text!)!
        //        let brightness = Float(brightBox.text!)!
        //        let po4 = Float(po4Box.text!)! / Float(lakeDepthBox.text!)!
        //        let total_chl = Float(chlBox.text!)!
        //        let cyano_chl = Float(cyanoChlBox.text!)!
        //        let depth = Float(lakeDepthBox.text!)!
        //
        //        // Retrieve PersistentContainer managed Context...
        //        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //
        //        // Retrieve Datalog entity from CoreData model.
        //        let entity = NSEntityDescription.entity(forEntityName: "Datalog", in: managedContext)
        //        let datalog = NSManagedObject(entity: entity!, insertInto: managedContext)
        //
        //        // Insert form data into CoreData model
        //        datalog.setValue(temp_diff, forKey: "temp_diff")
        //        datalog.setValue(brightness, forKey: "brightness")
        //        datalog.setValue(po4, forKey: "po4")
        //        datalog.setValue(total_chl, forKey: "total_chl")
        //        datalog.setValue(cyano_chl, forKey: "cyano_chl")
        //        datalog.setValue(depth, forKey: "depth")
        //
        // Create a new variable to store the instance of DataViewController
//        let tabbar = segue.destination as! UITabBarController
//        let destinationVC = tabbar.viewControllers?[0] as! DataViewController
        //
        ////        destinationVC.tempDiff = tempDiff
        ////        destinationVC.lux = lux
        ////        destinationVC.pav = pav
        ////        destinationVC.chl = chl
        ////        destinationVC.cyano = cyanoChl
        
        // Get input values from View.
        let temp_diff = Float(tempSurface.text!)! - Float(tempBottom.text!)!
        let brightness = Float(brightBox.text!)!
        let po4 = Float(po4Box.text!)! / Float(lakeDepthBox.text!)!
        let total_chl = Float(chlBox.text!)!
        let cyano_chl = Float(cyanoChlBox.text!)!
        let depth = Float(lakeDepthBox.text!)!
        
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
        
        // Save data.
        do {
            try managedContext.save()
            let id = datalog.objectID
            //            UserDefaults.standard.set(string, forKey: "userID")
            let results = managedContext.object(with: id)
            
            let tabbar = segue.destination as! UITabBarController
            let destinationVC = tabbar.viewControllers?[0] as! DataViewController
//            managedContext.object(with: id)
            destinationVC.id = id
        } catch let error as NSError {
            print ("Could not save \(error), \(error.userInfo)")
        }
        //
    }
    
    
    
}

