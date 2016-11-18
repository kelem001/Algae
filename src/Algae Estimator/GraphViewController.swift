//
//  GraphViewController.swift
//  Algae Estimator
//
//  Created by App Factory on 11/13/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//

//import UIKit
//import CoreData
//import Foundation
//import SwiftCharts
//
//class GraphViewController: UIViewController {
//
//    var xAxisConfig = ChartAxisConfig.init(from: 0, to: 396, by: 66)
//    var yAxisConfig = ChartAxisConfig.init(from: 0, to: 60, by: 10)
//    var xLabels = ChartLabelSettings.init(font: UIFont.systemFont(ofSize: UIFont.systemFontSize), fontColor: UIColor.black, textAlignment: ChartLabelTextAlignment.default)
//    var yLabels = ChartLabelSettings.init(font: UIFont.systemFont(ofSize: UIFont.systemFontSize), fontColor: UIColor.black, textAlignment: ChartLabelTextAlignment.default)
//    
//    
//    var chaxisLayer = ChartAxisLayer.self
//    var chaGuiLayer = ChartGuideLinesLayer.self
//    var chaPointLineLayber = ChartPointsLineLayer.self
//    var chaPointLayer = ChartPointsLayer.self
//    var chaxisInt = ChartAxisValueInt.self
//    
//    var chlaDataSet: Array<Float> = [Float]()
//    var cyanoDataSet: Array<Float> = [Float]()
//    
//    var chlaLine = [(Double, Double)]()
//    var cyanoLine = [(Double, Double)]()
//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()

//
//        chlaLine = [(Double, Double)](repeating: (0,0), count: chlaDataSet.count)
//        cyanoLine = [(Double, Double)](repeating: (0,0), count: cyanoDataSet.count)
//        
//        for i in 0..<chlaDataSet.count {
//            chlaLine[i] = (Double(i), Double(chlaDataSet[i]))
//            cyanoLine[i] = (Double(i), Double(cyanoDataSet[i]))
//        }
//        
//        let chartConfig = ChartConfigXY(
//            xAxisConfig: ChartAxisConfig(from: 0, to: 396, by: 66),
//            yAxisConfig: ChartAxisConfig(from: 0, to: 60, by: 10),
//            xAxisLabelSettings: ChartLabelSettings(),
//            yAxisLabelSettings: ChartLabelSettings()
//        )
//        
//        
//        let chart = LineChart(
//            frame: CGRect(x: self.view.bounds.minX + 20, y: self.view.bounds.minY + 80, width: self.view.bounds.width - 40, height: self.view.bounds.height - 150),
//            chartConfig: chartConfig,
//            xTitle: "X axis",
//            yTitle: "Y axis",
//            lines: [
//                (chartPoints: chlaLine, color: UIColor.red),
//                (chartPoints: cyanoLine, color: UIColor.blue),
//            ]
//        )
//        chart.view.backgroundColor = UIColor.white
//        
//        self.view.addSubview(chart.view)
//        
//        //Add grid, points, and lines here probably
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    fileprivate func createChartPoint(_ x: Double, _ y: Double, _ labelColor: UIColor) -> ChartPoint {
//        let labelSettings = ChartLabelSettings(font: UIFont.systemFont(ofSize: UIFont.systemFontSize), fontColor: labelColor)
//        return ChartPoint(x: ChartAxisValueDouble(x, labelSettings: labelSettings), y: ChartAxisValueDouble(y, labelSettings: labelSettings))
//    }
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}
        
//    }
//    
//}
///////////////////////////////////////////////////////////////////////////


import UIKit
import SwiftCharts
import CoreData
import Foundation

class GraphViewController: UIViewController {
    
    fileprivate var chart: Chart? // arc
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var chloro: Calculations?
        
        
        //var chlaDataSet = chloro?.getTotalChlaDataSet()
        //var cyanoDataSet = chloro?.getTotalChlaDataSet()
        
        
        //calculation = Calculations(total_chla: totalChl, cyano_chla: cyanoChl, Pbot: pbot, surtemp: tempTop!, bottemp: tempBot!, depth: depth!, lux: brightness!)

        
        
        //****************************************
        
        let labelSettings = ChartLabelSettings(font: UIFont.init(name: "Helvetica", size: 10)!)
        
        let chartPoints0 = [
            self.createChartPoint(2, 2, labelSettings),
            self.createChartPoint(4, 4, labelSettings),
            self.createChartPoint(7, 1, labelSettings),
            self.createChartPoint(8.3, 11.5, labelSettings),
            self.createChartPoint(9, 15.9, labelSettings),
            self.createChartPoint(10.8, 3, labelSettings),
            self.createChartPoint(13, 24, labelSettings),
            self.createChartPoint(15, 0, labelSettings),
            self.createChartPoint(17.2, 29, labelSettings),
            self.createChartPoint(20, 10, labelSettings),
            self.createChartPoint(22.3, 10, labelSettings),
            self.createChartPoint(27, 15, labelSettings),
            self.createChartPoint(30, 6, labelSettings),
            self.createChartPoint(40, 10, labelSettings),
            self.createChartPoint(50, 2, labelSettings),
            ]
        
        let chartPoints1 = [
            self.createChartPoint(2, 5, labelSettings),
            self.createChartPoint(3, 7, labelSettings),
            self.createChartPoint(5, 9, labelSettings),
            self.createChartPoint(8, 6, labelSettings),
            self.createChartPoint(9, 10, labelSettings),
            self.createChartPoint(10, 20, labelSettings),
            self.createChartPoint(12, 19, labelSettings),
            self.createChartPoint(13, 20, labelSettings),
            self.createChartPoint(14, 25, labelSettings),
            self.createChartPoint(16, 28, labelSettings),
            self.createChartPoint(17, 15, labelSettings),
            self.createChartPoint(19, 6, labelSettings),
            self.createChartPoint(25, 3, labelSettings),
            self.createChartPoint(30, 10, labelSettings),
            self.createChartPoint(45, 15, labelSettings),
            self.createChartPoint(50, 20, labelSettings),
            ]
        
        let xValues = stride(from: 0, through: 396, by: 66).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)}
        let yValues = ChartAxisValuesGenerator.generateYAxisValuesWithChartPoints(chartPoints0, minSegmentCount: 4, maxSegmentCount: 20, multiple: 10, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: true)
        //let yValues = stride(from: 0, through: 240, by: 10).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)}
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Time (h)", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Chl a\nConc.\n(μg/L)", settings: labelSettings))
       
        
        
        //let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Chl a \nConc. \n(μg/L)", settings: labelSettings.copy(UIFont.init(name: "Helvetica", size: 10), fontColor: UIColor.black, rotation: 0, rotationKeep: ChartLabelDrawerRotationKeep, shiftXOnRotation: false)))
        
        let scrollViewFrame = CGRect(x: self.view.bounds.minX + 20, y: self.view.bounds.minY + 80, width: self.view.bounds.width - 40, height: self.view.bounds.height - 150)
        
        
        //let chartFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width - 40, height: scrollViewFrame.size.height)
        let chartFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width - 40, height: self.view.bounds.height - 150)
        
        // calculate coords space in the background to keep UI smooth
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            
            let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: FormatForDevice.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
            
            DispatchQueue.main.async {
                let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
                
                let lineModel0 = ChartLineModel(chartPoints: chartPoints0, lineColor: UIColor.red, animDuration: 1, animDelay: 0)
                let lineModel1 = ChartLineModel(chartPoints: chartPoints1, lineColor: UIColor.blue, animDuration: 1, animDelay: 0, dashPattern: [5,10])
                let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel0, lineModel1])
                
                
                let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: Env.iPad ? 0.5 : 0.1)
                
                
                let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
                
                let scrollView = UIScrollView(frame: scrollViewFrame)
                scrollView.contentSize = CGSize(width: chartFrame.size.width, height: scrollViewFrame.size.height)
                //        self.automaticallyAdjustsScrollViewInsets = false // nested view controller - this is in parent
                
                let chart = Chart(
                    frame: chartFrame,
                    layers: [
                        xAxis,
                        yAxis,
                        guidelinesLayer,
                        chartPointsLineLayer
                    ]
                )
                
                scrollView.addSubview(chart.view)
                self.view.addSubview(scrollView)
                self.chart = chart
                
            }
        }
    }
    
    fileprivate func createChartPoint(_ x: Double, _ y: Double, _ labelSettings: ChartLabelSettings) -> ChartPoint {
        return ChartPoint(x: ChartAxisValueDouble(x, labelSettings: labelSettings), y: ChartAxisValueDouble(y))
    }
}


///////////////////////////////////////////////////////////////////////////


class Env {
    static var iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}

struct FormatForDevice {
    static var chartSettings: ChartSettings {
        if Env.iPad {
            return self.iPadChartSettings
        } else {
            return self.iPhoneChartSettings
        }
    }
    
    fileprivate static var iPadChartSettings: ChartSettings {
        let chartSettings = ChartSettings()
        chartSettings.leading = 20
        chartSettings.top = 20
        chartSettings.trailing = 20
        chartSettings.bottom = 20
        chartSettings.labelsToAxisSpacingX = 10
        chartSettings.labelsToAxisSpacingY = 10
        chartSettings.axisTitleLabelsToLabelsSpacing = 5
        chartSettings.axisStrokeWidth = 1
        chartSettings.spacingBetweenAxesX = 15
        chartSettings.spacingBetweenAxesY = 15
        return chartSettings
    }
    
    fileprivate static var iPhoneChartSettings: ChartSettings {
        let chartSettings = ChartSettings()
        chartSettings.leading = 10
        chartSettings.top = 10
        chartSettings.trailing = 10
        chartSettings.bottom = 10
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 8
        return chartSettings
    }
}
