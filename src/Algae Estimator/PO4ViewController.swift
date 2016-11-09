//
//  PO4ViewController.swift
//  Algae Estimator
//
//  Created by App Factory on 10/19/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit
import CoreData

class PO4ViewController: UIViewController {

    var dataEntryVals: [String:Float] = [:]
    var logID: NSManagedObjectID?
    
    @IBOutlet weak var po4TextField: UITextField!
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        //performSegue(withIdentifier: "backToDataEntry", sender: self)
    }
    
    
    @IBAction func po4ConButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 10
        _updateDataEntryVals()
        result.dataEntryVals = dataEntryVals
        self.present(result, animated: true, completion: nil)
    }

    private func _updateDataEntryVals() {
        if po4TextField.text != "" {
            dataEntryVals["po4"] = Float(po4TextField.text!)!
        } else {
            dataEntryVals["po4"] = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "backToDataEntry") {
            _updateDataEntryVals()
            let tabbar = segue.destination as! UITabBarController
            let dest = tabbar.viewControllers?[0] as! CalculateViewController
            dest.dataEntryVals = dataEntryVals
            dest.startEdit = false
            
            for e in dataEntryVals {
                NSLog(String(describing:e))
            }
            
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
        if dataEntryVals["po4"] != nil {
            po4TextField.text = String(describing: dataEntryVals["po4"]!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
