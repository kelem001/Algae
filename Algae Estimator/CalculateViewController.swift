//
//  ViewController.swift
//  Algae Estimator
//
//  Created by App Factory on 9/30/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit

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
    
    
    @IBOutlet weak var chlBox: UITextField!
    @IBOutlet weak var chLabel: UILabel!
    
    //For now, this button calculates the results, making sure this all
    //works. Will need to use submit button and have results project to
    //another page
    
    @IBAction func fakeSubmit(_ sender: AnyObject) {
        //temp difference
        //Suface - Bottom = Difference
        let result = Double(tempSurface.text!)! - Double(tempBottom.text!)!
        tempDiffLabel.text = result.description
        
        //Lux
        let lux = Double(brightBox.text!)!
        luxLabel.text = lux.description
        
        //Pav
        //PO4 / Depth = Pav
        let pav = Double(po4Box.text!)! / Double(lakeDepthBox.text!)!
        pavLabel.text = pav.description
        
        //Chl
        let chl = Double(chlBox.text!)!
        chLabel.text = chl.description
        
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

