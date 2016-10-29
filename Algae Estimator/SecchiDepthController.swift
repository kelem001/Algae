//
//  SecchiDepthController.swift
//  Algae Estimator
//
//  Created by App Factory on 10/28/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit


class SecchiDepthController : UIViewController {
    @IBAction func SecchiDepthButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 8
        self.present(result, animated: true, completion: nil)
    }
    @IBAction func DissolvedOxygenButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 9
        self.present(result, animated: true, completion: nil)
    }

}
