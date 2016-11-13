//
//  ChlViewController.swift
//  Algae Estimator
//
//  Created by Derek Riley on 10/28/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit
import CoreData

class ChlViewController: UIViewController {
    
    var dataEntryVals: [String:Float] = [:]
    var logID: NSManagedObjectID?
    
    @IBOutlet weak var totalChlTextfield: UITextField!
    @IBOutlet weak var cyanoChlTextfield: UITextField!
    
    @IBAction func submitButton(_ sender: UIButton) {
       // performSegue(withIdentifier: "submit", sender: self)
    }
    
    
    @IBAction func CyanoChlButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 7
        _updateDataEntryVals()
        result.dataEntryVals = dataEntryVals
        self.present(result, animated: true, completion: nil)
    }
    
    private func _updateDataEntryVals() {
        if totalChlTextfield.text != "" && Float(totalChlTextfield.text!) != nil {
            dataEntryVals["totalChl"] = Float(totalChlTextfield.text!)!
        } else {
            dataEntryVals["totalChl"] = nil
        }
        if cyanoChlTextfield.text! != "" && Float(cyanoChlTextfield.text!) != nil {
            dataEntryVals["cyanoChl"] = Float(cyanoChlTextfield.text!)!
        } else {
            dataEntryVals["cyanoChl"] = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        _updateDataEntryVals()
        
        if (segue.identifier == "submit") {
            
            let tabbar = segue.destination as! UITabBarController
            let dest = tabbar.viewControllers?[0] as! CalculateViewController
            
            dest.dataEntryVals = dataEntryVals
            dest.startEdit = false
            if logID != nil {
                dest.logID = logID
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if dataEntryVals["totalChl"] != nil {
            totalChlTextfield.text = String(describing: dataEntryVals["totalChl"]!)
        }
        if dataEntryVals["cyanoChl"] != nil {
            cyanoChlTextfield.text = String(describing: dataEntryVals["cyanoChl"]!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
