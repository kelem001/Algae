//
//  ChlViewController.swift
//  Algae Estimator
//
//  Created by Derek Riley on 10/28/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit

class ChlEstimateViewController: UIViewController {
    
    var dataEntryVals: [String:Float] = [:]
    
    @IBOutlet weak var dissolvedOxygenTextfield: UITextField!
    @IBOutlet weak var secciDepthTextfield: UITextField!
    
    @IBAction func submitButton(_ sender: UIButton) {
        performSegue(withIdentifier: "submit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if secciDepthTextfield.text != "" {
            dataEntryVals["secciDepth"] = Float(secciDepthTextfield.text!)!
        }
        if dissolvedOxygenTextfield.text != "" {
            dataEntryVals["dissolvedOxygen"] = Float(dissolvedOxygenTextfield.text!)!
        }
        
        if (segue.identifier == "submit") {
            
            let tabbar = segue.destination as! UITabBarController
            let dest = tabbar.viewControllers?[0] as! CalculateViewController
            
            dest.dataEntryVals = dataEntryVals
            
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
