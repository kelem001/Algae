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
    
    
    @IBOutlet weak var brightBox: UITextField!
    @IBOutlet weak var luxLabel: UILabel!
    
    
    @IBOutlet weak var po4Box: UITextField!
    @IBOutlet weak var lakeDepthBox: UITextField!
    @IBOutlet weak var pavLabel: UILabel!
    
    @IBAction func fakeSubmit(_ sender: AnyObject) {
        //temp difference
        let result = Double(tempSurface.text!)! - Double(tempBottom.text!)!
        tempDiffLabel.text = result.description
        
        //Lux
        let lux = Double(brightBox.text!)!
        luxLabel.text = lux.description
        
        //Pav
        let pav = Double(po4Box.text!)! / Double(lakeDepthBox.text!)!
        pavLabel.text = pav.description
        
        
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

