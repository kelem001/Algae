//
//  ViewController.swift
//  Algae Estimator
//
//  Created by App Factory on 9/30/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MAKE: PO4-Direct-Properties
    @IBOutlet weak var PO4DirectBack: UIButton!
    @IBOutlet weak var PO4DirectTopText: UILabel!
    @IBOutlet weak var PO4DirectSlider: UISegmentedControl!
    @IBOutlet weak var PO4DirectLabel: UILabel!
    @IBOutlet weak var PO4DirectInputBox: UITextField!
    @IBOutlet weak var PO4DirectHelp: UIButton!
    @IBOutlet weak var PO4DirectSubmit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("I can not wait to push this to Github!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MAKE: Actions
    @IBAction func PO4DirectSegmentChanger(_ sender: UISegmentedControl) {
//        if (PO4DirectSlider.selectedSegmentIndex == 0) {
//            
//        } else if (PO4DirectSlider.selectedSegmentIndex == 1) {
//            
//        }
        
    }
    
    

}

