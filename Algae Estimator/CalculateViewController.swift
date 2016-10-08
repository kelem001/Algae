//
//  ViewController.swift
//  Algae Estimator
//
//  Created by App Factory on 9/30/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var tempSurface: UITextField!
    @IBOutlet weak var tempBottom: UITextField!
    @IBOutlet weak var tempDiffLabel: UILabel!
    
    
    
    @IBAction func fakeSubmit(_ sender: AnyObject) {
        //temp difference
        let result = Double(tempSurface.text!)! - Double(tempBottom.text!)!
        tempDiffLabel.text = result.description
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

