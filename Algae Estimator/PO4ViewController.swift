//
//  PO4ViewController.swift
//  Algae Estimator
//
//  Created by App Factory on 10/19/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit

class PO4ViewController: UIViewController {

    var dataEntryVals: [String:Float] = [:]
    
    @IBOutlet weak var po4TextField: UITextField!
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        performSegue(withIdentifier: "backToDataEntry", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "backToDataEntry") {
            dataEntryVals["po4"] = Float(po4TextField.text!)!
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
        if dataEntryVals["po4"] != nil {
            po4TextField.text = String(describing: dataEntryVals["po4"]!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
