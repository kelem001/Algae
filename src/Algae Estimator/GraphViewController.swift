//
//  GraphViewController.swift
//  Algae Estimator
//
//  Created by App Factory on 11/13/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import SwiftCharts

class GraphViewController: UIViewController {
    
    var chartCon = ChartAxisConfig.self
    var chaxisLayer = ChartAxisLayer.self
    var chaGuiLayer = ChartGuideLinesLayer.self
    var chaPointLineLayber = ChartPointsLineLayer.self
    var chaPointLayer = ChartPointsLayer.self
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //sets background color to white
//        self.view.backgroundColor = UIColor.white
        
        let chartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 0, to: 396, by: 66),
            yAxisConfig: ChartAxisConfig(from: 0, to: 60, by: 10),
            xAxisLabelSettings: ChartLabelSettings()
        )
        
        //ORigin = topleft
        //x = left and right
        //y = up and down
        
        let chart = LineChart(
//            frame: CGRect(x: 50 ,y: (self.navigationController?.navigationBar.frame.height)! + 50,width: self.view.frame.width - 100 ,height: self.view.frame.height - (self.navigationController?.navigationBar.frame.height)! - (self.tabBarController?.tabBar.frame.height)! - 50),
//            frame: self.view.bounds,
            frame: CGRect(x: self.view.bounds.minX + 50, y: self.view.bounds.minY + 100, width: self.view.bounds.width - 100, height: self.view.bounds.height - 200),
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            lines: [
                (chartPoints: [(2.0, 2.0), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.red),
                (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blue)
            ]
        )
        chart.view.backgroundColor = UIColor.black
        
        self.view.addSubview(chart.view)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}
 

}
