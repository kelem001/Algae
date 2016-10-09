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
    
    @IBOutlet weak var cyanoChlBox: UITextField!
    
    @IBOutlet weak var chlBox: UITextField!
    @IBOutlet weak var chLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Create a variable that you want to send
    
            let tempDiff = Float(tempSurface.text!)! - Float(tempBottom.text!)!
            NSLog(String(tempDiff))
            let lux = Float(brightBox.text!)!
            let pav = Float(po4Box.text!)! / Float(lakeDepthBox.text!)!
            let chl = Float(chlBox.text!)!
            let cyanoChl = Float(cyanoChlBox.text!)!
    
            // Create a new variable to store the instance of PlayerTableViewController
            let tabbar = segue.destination as! UITabBarController
            let destinationVC = tabbar.viewControllers?[0] as! DataViewController
    
            destinationVC.tempDiff = tempDiff
            destinationVC.lux = lux
            destinationVC.pav = pav
            destinationVC.chl = chl
            destinationVC.cyano = cyanoChl
            
        }



}

