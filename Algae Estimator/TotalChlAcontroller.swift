//
//  TotalChlAcontroller.swift
//  Algae Estimator
//
//  Created by App Factory on 10/28/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit


class TotalChlAcontroller : UIViewController {

    @IBAction func CyanoChlButton(_ sender: AnyObject) {
        let result = self.storyboard?.instantiateViewController(withIdentifier: "resultVC")
            as! ResultViewController
        result.number = 7
        self.present(result, animated: true, completion: nil)
    }
}
