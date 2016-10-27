//
//  PO4EstimatesViewController.swift
//  Algae Estimator
//
//  Created by App Factory on 10/26/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit
import CoreData

class PO4EstimatesViewController: UIViewController {

    // MAKE:Properties
    @IBOutlet weak var po4Val: UILabel!
    @IBOutlet weak var farmButton: UISegmentedControl!
    @IBOutlet weak var naturalButton: UISegmentedControl!
    @IBOutlet weak var plantSeek: UISlider!
    @IBOutlet weak var bloomSeek: UISlider!
    //@IBOutlet weak var sendPO4Val: UIButton!
    
    
    @IBAction func sendP04Val(_ sender: AnyObject) {
        performSegue(withIdentifier: "segueSend2", sender: self)
    }
    
    var location:Float = 0.065
    var landVegetation:Float = 0.002
    var waterVegetation:Float = 0.034
    var recurringBlooms:Float = 0.002
    var scaleBloom:Float = (0.065-0.002)/100
    var scalePlant:Float = (0.065-0.034)/100
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func landIndexChanged(sender: UISegmentedControl) {
        switch farmButton.selectedSegmentIndex
        {
        case 0:
            // Farm land segment
            location = 0.065
            calculatePO4()
        case 1:
            // Urban segment
            location = 0.034
            calculatePO4()
        default:
            break;
        }
    }
    
    @IBAction func vegIndexChanged(sender: UISegmentedControl) {
        switch naturalButton.selectedSegmentIndex
        {
        case 0:
            // Natural segment
            landVegetation = 0.002
            calculatePO4()
        case 1:
            // Land segment
            landVegetation = 0.065
            calculatePO4()
        case 2:
            // Sand segment
            landVegetation = 0.002
            calculatePO4()
        default:
            break;
        }
    }
    
    @IBAction func plantSliderValueChanged(sender: UISlider) {
        let selectedValue = Float(sender.value)
        
        waterVegetation = 0.034+(selectedValue*scalePlant)
        calculatePO4()
    }
    
    @IBAction func freqSliderValueChanged(sender: UISlider) {
        let selectedValue = Float(sender.value)
        
        recurringBlooms = 0.002+(selectedValue*scaleBloom)
        calculatePO4()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueSend2") {
            let tabbar = segue.destination as! UITabBarController
            let destinationVC = tabbar.viewControllers?[0] as! CalculateViewController
            
            
            destinationVC.po4Est = Float(po4Val.text!)!
            //round(1000*finalVal)/10000
        }
    }
    
    func calculatePO4(){
        let value:Float = 0.1*location + 0.4*landVegetation + 0.1*waterVegetation + 0.4*recurringBlooms;
        let finalVal:  Float = 44.2222*value - 0.36
        po4Val.text = String(format: "%.4f",(round(10000*finalVal)/10000))
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
