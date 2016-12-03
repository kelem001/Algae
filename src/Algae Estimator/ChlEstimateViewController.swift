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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.addDoneButtonOnKeyboard()
        
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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        _updateDataEntryVals()
        
        var formValid = true
        var msg = ""
        
        if formValid && dataEntryVals["secciDepth"] != nil {
            if dataEntryVals["secciDepth"]! < 0.0 || dataEntryVals["secciDepth"]! > 1.0 {
                formValid = false
                msg = "Please input Secchi Depth value between 0 and 1."
            }
        }
        
        if formValid && dataEntryVals["dissolvedOxygen"] != nil {
            if dataEntryVals["dissolvedOxygen"]! < 1.0 || dataEntryVals["dissolvedOxygen"]! > 100.0 {
                formValid = false
                msg = "Please input Oxygen Dissolved value between 1 and 100."
            }
        }
        
        if !formValid {
            let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return formValid
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
        
        dataEntryVals["totalChl"] = nil
        dataEntryVals["cyanoChl"] = nil
        
    }
    
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(CalculateViewController.dismissKeyboard))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.dissolvedOxygenTextfield.inputAccessoryView = doneToolbar
        self.secciDepthTextfield.inputAccessoryView = doneToolbar
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
