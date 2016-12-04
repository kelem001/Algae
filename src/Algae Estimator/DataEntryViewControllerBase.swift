//
//  ViewController.swift
//  Algae Estimator
//
//  Created by App Factory on 9/30/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit
import CoreData
import SwiftCharts

class DataEntryViewControllerBase: UIViewController, UITextFieldDelegate {
    
    var currentTextField: UITextField!
    var uiToolbar: UIToolbar!
    
    var dataEntryVals: [String:Float] = [:]
    var logID: NSManagedObjectID?
    var validChl = false
    var validPO4 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.uiToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        self.uiToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.dismissKeyboard))
        let next: UIBarButtonItem  = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.nextField))
        
        var items = [UIBarButtonItem]()
        items.append(done)
        items.append(flexSpace)
        items.append(next)
        
        self.uiToolbar.items = items
        self.uiToolbar.sizeToFit()
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func nextField() {
        // Try to find next responder
        if let nextField = currentTextField.superview?.viewWithTag(currentTextField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            self.dismissKeyboard()
        }
    }
    
}
