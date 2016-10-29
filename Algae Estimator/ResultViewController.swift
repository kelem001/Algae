//
//  ResultViewController.swift
//  Algae Estimator
//
//  Created by App Factory on 10/28/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit


class ResultViewController : UIViewController {
    
    
    private var transport:MyConstants.Transport?
    
    
    
    var number: Int = 0
    
    @IBOutlet weak var myLabel: UILabel!
    
    
    
    @IBOutlet weak var myImage: UIImageView!
    
    
    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        self.preferredContentSize = CGSize(width: 150, height: 150)
        
        
        
        myLabel.text = transport?.rawValue
        
        
        switch number {
        case 1:
            myImage.image = UIImage(named: "dialog_chla")
        case 2:
            myImage.image = UIImage(named: "dialog_luxmeter")
        case 3:
            myImage.image = UIImage(named: "dialog_secchi_disk")
        case 4:
            myImage.image = UIImage(named: "dialog_bottemp")
        case 5:
            myImage.image = UIImage(named: "dialog_surtemp")
        case 6:
            myImage.image = UIImage(named: "")
        default:
            myImage.image = UIImage(named: "")

        }
        //myImage.image = UIImage(named: (transport?.rawValue)!)
    }
    
    @IBAction func goBack(sender: AnyObject) {
        
        
    }
    
    
    func setTransport ( transport:MyConstants.Transport){
        self.transport = transport
    }
}
