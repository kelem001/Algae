//
//  ChlViewController.swift
//  Algae Estimator
//
//  Created by Derek Riley on 10/28/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit
import CoreData

class ChlEstimateViewController: UIViewController {
    
    
    var dataEntryVals: [String:Float] = [:]
    var logID: NSManagedObjectID?
    var validPO4: Bool?
    
    @IBOutlet weak var dissolvedOxygenTextfield: UITextField!
    @IBOutlet weak var secciDepthTextfield: UITextField!
    
    @IBAction func SecchiDepthButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 8
        self.present(result, animated: true, completion: nil)
    }
    @IBAction func DissolvedOxygenButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 9
        _updateDataEntryVals()
        result.dataEntryVals = dataEntryVals
        self.present(result, animated: true, completion: nil)
    }

    
    @IBAction func submitButton(_ sender: UIButton) {
       // performSegue(withIdentifier: "submit", sender: self)
    }
    
    private func _updateDataEntryVals() {
        if secciDepthTextfield.text != "" && Float(secciDepthTextfield.text!) != nil {
            dataEntryVals["secciDepth"] = Float(secciDepthTextfield.text!)!
        } else {
            dataEntryVals["secciDepth"] = nil
        }
        if dissolvedOxygenTextfield.text != "" && Float(dissolvedOxygenTextfield.text!) != nil {
            dataEntryVals["dissolvedOxygen"] = Float(dissolvedOxygenTextfield.text!)!
        } else {
            dataEntryVals["dissolvedOxygen"] = nil
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
            
            if dataEntryVals["secciDepth"] != nil && dataEntryVals["dissolvedOxygen"] != nil && dataEntryVals["secciDepth"]! >= 0.0 && dataEntryVals["secciDepth"]! <= 1.0 && dataEntryVals["dissolvedOxygen"]! >= 1.0 && dataEntryVals["dissolvedOxygen"]! <= 100.0 {
                dest.validChl = true
            } else {dest.validChl = false}
            dest.validPO4 = validPO4!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if dataEntryVals["secciDepth"] != nil {
            secciDepthTextfield.text = String(describing: dataEntryVals["secciDepth"]!)
        }
        if dataEntryVals["dissolvedOxygen"] != nil {
            dissolvedOxygenTextfield.text = String(describing: dataEntryVals["dissolvedOxygen"]!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
