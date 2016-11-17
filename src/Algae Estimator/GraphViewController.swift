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

    var xAxisConfig = ChartAxisConfig.init(from: 0, to: 396, by: 66)
    var yAxisConfig = ChartAxisConfig.init(from: 0, to: 60, by: 10)
    var xLabels = ChartLabelSettings.init(font: UIFont.systemFont(ofSize: UIFont.systemFontSize), fontColor: UIColor.black, textAlignment: ChartLabelTextAlignment.default)
    var yLabels = ChartLabelSettings.init(font: UIFont.systemFont(ofSize: UIFont.systemFontSize), fontColor: UIColor.black, textAlignment: ChartLabelTextAlignment.default)
    
    
    var chaxisLayer = ChartAxisLayer.self
    var chaGuiLayer = ChartGuideLinesLayer.self
    var chaPointLineLayber = ChartPointsLineLayer.self
    var chaPointLayer = ChartPointsLayer.self
    
    var chlaDataSet: Array<Float> = [Float]()
    var cyanoDataSet: Array<Float> = [Float]()
    
    var chlaLine = [(Double, Double)]()
    var cyanoLine = [(Double, Double)]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        
        chlaLine = [(Double, Double)](repeating: (0,0), count: chlaDataSet.count)
        cyanoLine = [(Double, Double)](repeating: (0,0), count: cyanoDataSet.count)
        
        for i in 0..<chlaDataSet.count {
            chlaLine[i] = (Double(i), Double(chlaDataSet[i]))
            cyanoLine[i] = (Double(i), Double(cyanoDataSet[i]))
        }
        
        let chartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 0, to: 396, by: 66),
            yAxisConfig: ChartAxisConfig(from: 0, to: 60, by: 10),
            xAxisLabelSettings: ChartLabelSettings(),
            yAxisLabelSettings: ChartLabelSettings()
        )
        
        
        let chart = LineChart(
            frame: CGRect(x: self.view.bounds.minX + 20, y: self.view.bounds.minY + 80, width: self.view.bounds.width - 40, height: self.view.bounds.height - 150),
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            lines: [
                (chartPoints: chlaLine, color: UIColor.red),
                (chartPoints: cyanoLine, color: UIColor.blue),
            ]
        )
        chart.view.backgroundColor = UIColor.white
        
        self.view.addSubview(chart.view)
        
        //Add grid, points, and lines here probably
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func createChartPoint(_ x: Double, _ y: Double, _ labelColor: UIColor) -> ChartPoint {
        let labelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: UIFont.systemFontSize), fontColor: labelColor)
        return ChartPoint(x: ChartAxisValueDouble(x, labelSettings: labelSettings), y: ChartAxisValueDouble(y, labelSettings: labelSettings))
    }
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}
}

///////////////////////////////////////////////////////////////////////////

