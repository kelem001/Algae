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
//
//        
////        chlaLine = [(Double, Double)](repeating: (0,0), count: chlaDataSet.count)
////        cyanoLine = [(Double, Double)](repeating: (0,0), count: cyanoDataSet.count)
////        
////        for i in 0..<chlaDataSet.count {
////            chlaLine[i] = (Double(i), Double(chlaDataSet[i]))
////            cyanoLine[i] = (Double(i), Double(cyanoDataSet[i]))
////        }
////        
////        let chartConfig = ChartConfigXY(
////            xAxisConfig: ChartAxisConfig(from: 0, to: 396, by: 66),
////            yAxisConfig: ChartAxisConfig(from: 0, to: 60, by: 10),
////            xAxisLabelSettings: ChartLabelSettings()
////        )
////        
////        
////        let chart = LineChart(
////            frame: CGRect(x: self.view.bounds.minX + 50, y: self.view.bounds.minY + 100, width: self.view.bounds.width - 100, height: self.view.bounds.height - 200),
////            chartConfig: chartConfig,
////            xTitle: "X axis",
////            yTitle: "Y axis",
////            lines: [
////                (chartPoints: chlaLine, color: UIColor.red),
////                (chartPoints: cyanoLine, color: UIColor.blue),
//////                (chartPoints: chartPoints, color: UIColor.white)
////            ]
////        )
////        chart.view.backgroundColor = UIColor.black
////        
////        self.view.addSubview(chart.view)
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
//    
//    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    //}
//}

///////////////////////////////////////////////////////////////////////////

private extension UIColor {
    static let secondaryLabelColor = UIColor(red: 142 / 255, green: 142 / 255, blue: 147 / 255, alpha: 1)
    
    static let gridColor = UIColor(white: 193 / 255, alpha: 1)
    
    static let glucoseTintColor = UIColor(red: 96 / 255, green: 201 / 255, blue: 248 / 255, alpha: 1)
    
    static let IOBTintColor: UIColor = UIColor(red: 254 / 255, green: 149 / 255, blue: 38 / 255, alpha: 1)
}

private let dateFormatter: DateFormatter = {
    let timeFormatter = DateFormatter()
    timeFormatter.dateStyle = .none
    timeFormatter.timeStyle = .short
    
    return timeFormatter
}()

private let localDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    return dateFormatter
}()

private let decimalFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.minimumFractionDigits = 2
    numberFormatter.maximumFractionDigits = 2
    
    return numberFormatter
}()

// MARK – Fixture data
private let glucosePoints: [ChartPoint] = [(0.0, 0.0), (1.0, 1.0), (2.0, 2.0)].map {_,_ in 
    return ChartPoint(
        x: ChartAxisValueDouble(0.1, formatter: decimalFormatter),
        y: ChartAxisValueDouble(0.1, formatter: decimalFormatter)
    )
}

private let predictedGlucosePoints: [ChartPoint] = [(0.0, 0.0)].map {_,_ in
    return ChartPoint(
        x: ChartAxisValueDouble(0.1, formatter: decimalFormatter),
        y: ChartAxisValueDouble(0.1, formatter: decimalFormatter)
    )
}

private let IOBPoints: [ChartPoint] = [(0.0, 0.0)].map {_,_ in
    return ChartPoint(
        x: ChartAxisValueDouble(0.1, formatter: decimalFormatter),
        y: ChartAxisValueDouble(0.1, formatter: decimalFormatter)
    )
}


class GraphViewController: UIViewController, UIGestureRecognizerDelegate {
    
    fileprivate var topChart: Chart?
    
//    fileprivate var bottomChart: Chart?
    
    fileprivate lazy var chartPanGestureRecognizer = UIPanGestureRecognizer()
    
    // MARK: – Chart configuration
    fileprivate lazy var chartSettings: ChartSettings = {
        let chartSettings = ChartSettings()
        chartSettings.top = 12
        chartSettings.bottom = 0
        chartSettings.trailing = 8
        chartSettings.axisTitleLabelsToLabelsSpacing = 0
        chartSettings.labelsToAxisSpacingX = 6
        chartSettings.labelsWidthY = 30
        
        return chartSettings
    }()
    
    private let axisLabelSettings: ChartLabelSettings = ChartLabelSettings()
    
    private let guideLinesLayerSettings: ChartGuideLinesLayerSettings = ChartGuideLinesLayerSettings()
    
    fileprivate lazy var axisLineColor = UIColor.black
    
    fileprivate var xAxisValues: [ChartAxisValue]? {
        didSet {
            if let xAxisValues = xAxisValues {
                xAxisModel = ChartAxisModel(axisValues: xAxisValues, lineColor: axisLineColor)
            } else {
                xAxisModel = nil
            }
        }
    }
    
    fileprivate var xAxisModel: ChartAxisModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartPanGestureRecognizer.delegate = self
        view.addGestureRecognizer(chartPanGestureRecognizer)
        
        generateXAxisValues()
        
        let topFrame = CGRect(x: 0.0, y: 100.0, width: self.view.frame.width, height: self.view.frame.height - 200.0)
        
//        let (topFrame, bottomFrame) = fullFrame.divided(atDistance: fullFrame.height / 2, from: .minYEdge)
        
        topChart = generateGlucoseChartWithFrame(topFrame)
//        bottomChart = generateIOBChartWithFrame(bottomFrame)
        
        self.view.addSubview((topChart?.view)!)
//        for chart in [topChart, bottomChart] {
//            if let view = chart?.view {
//                self.view.addSubview(view)
//            }
//        }
    }
    
    fileprivate func generateXAxisValues() {
        let points = glucosePoints + predictedGlucosePoints
        
        guard points.count > 1 else {
            self.xAxisValues = []
            return
        }
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h a"
        
        let xAxisValues = ChartAxisValuesGenerator.generateXAxisValuesWithChartPoints(points, minSegmentCount: 5, maxSegmentCount: 10, multiple: TimeInterval(60 * 1000), axisValueGenerator: { ChartAxisValueDate(date: ChartAxisValueDate.dateFromScalar($0), formatter: timeFormatter, labelSettings: self.axisLabelSettings)
        }, addPaddingSegmentIfEdge: false)
        xAxisValues.first?.hidden = false
        xAxisValues.last?.hidden = false
        
        self.xAxisValues = xAxisValues
    }
    
    fileprivate func generateGlucoseChartWithFrame(_ frame: CGRect) -> Chart? {
        guard glucosePoints.count > 1, let xAxisModel = xAxisModel else {
            return nil
        }
        
        let allPoints = glucosePoints + predictedGlucosePoints
        
        // TODO: The segment/multiple values are unit-specific
        let yAxisValues = ChartAxisValuesGenerator.generateYAxisValuesWithChartPoints(allPoints, minSegmentCount: 5, maxSegmentCount: 7, multiple: 10, axisValueGenerator: { ChartAxisValueDouble($0, labelSettings: self.axisLabelSettings) }, addPaddingSegmentIfEdge: true)
        
        let yAxisModel = ChartAxisModel(axisValues: yAxisValues, lineColor: axisLineColor)
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: frame, xModel: xAxisModel, yModel: yAxisModel)
        
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let gridLayer = ChartGuideLinesLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, axis: .xAndY, settings: guideLinesLayerSettings, onlyVisibleX: true, onlyVisibleY: false)
        
        let circles = ChartPointsScatterCirclesLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: glucosePoints, displayDelay: 0, itemSize: CGSize(width: 4, height: 4), itemFillColor: UIColor.glucoseTintColor)
        
        var prediction: ChartLayer?
        
        if predictedGlucosePoints.count > 1 {
            prediction = ChartPointsScatterCirclesLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: predictedGlucosePoints, displayDelay: 0, itemSize: CGSize(width: 2, height: 2), itemFillColor: UIColor.glucoseTintColor.withAlphaComponent(0.75))
        }
        
        let highlightLayer = ChartPointsTouchHighlightLayer(
            xAxis: xAxis,
            yAxis: yAxis,
            innerFrame: innerFrame,
            chartPoints: allPoints,
            tintColor: UIColor.glucoseTintColor,
            labelCenterY: chartSettings.top,
            gestureRecognizer: chartPanGestureRecognizer
        )
        
        let layers: [ChartLayer?] = [
            gridLayer,
            xAxis,
            yAxis,
            highlightLayer,
            prediction,
            circles
        ]
        
        return Chart(frame: frame, layers: layers.flatMap { $0 })
    }
    
    fileprivate func generateIOBChartWithFrame(_ frame: CGRect) -> Chart? {
        guard IOBPoints.count > 1, let xAxisModel = xAxisModel else {
            return nil
        }
        
        var containerPoints = IOBPoints
        
        // Create a container line at 0
        if let first = IOBPoints.first {
            containerPoints.insert(ChartPoint(x: first.x, y: ChartAxisValueInt(0)), at: 0)
        }
        
        if let last = IOBPoints.last {
            containerPoints.append(ChartPoint(x: last.x, y: ChartAxisValueInt(0)))
        }
        
        let yAxisValues = ChartAxisValuesGenerator.generateYAxisValuesWithChartPoints(IOBPoints, minSegmentCount: 2, maxSegmentCount: 3, multiple: 0.5, axisValueGenerator: { ChartAxisValueDouble($0, labelSettings: self.axisLabelSettings) }, addPaddingSegmentIfEdge: false)
        
        let yAxisModel = ChartAxisModel(axisValues: yAxisValues, lineColor: axisLineColor)
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: frame, xModel: xAxisModel, yModel: yAxisModel)
        
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        // The IOB area
        let lineModel = ChartLineModel(chartPoints: IOBPoints, lineColor: UIColor.IOBTintColor, lineWidth: 2, animDuration: 0, animDelay: 0)
        let IOBLine = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel])
        
        let IOBArea = ChartPointsAreaLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: containerPoints, areaColor: UIColor.IOBTintColor.withAlphaComponent(0.5), animDuration: 0, animDelay: 0, addContainerPoints: false)
        
        // Grid lines
        let gridLayer = ChartGuideLinesLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, axis: .xAndY, settings: guideLinesLayerSettings, onlyVisibleX: true, onlyVisibleY: false)
        
        // 0-line
        let dummyZeroChartPoint = ChartPoint(x: ChartAxisValueDouble(0), y: ChartAxisValueDouble(0))
        let zeroGuidelineLayer = ChartPointsViewsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: [dummyZeroChartPoint], viewGenerator: {(chartPointModel, layer, chart) -> UIView? in
            let width: CGFloat = 0.5
            let viewFrame = CGRect(x: innerFrame.origin.x, y: chartPointModel.screenLoc.y - width / 2, width: innerFrame.size.width, height: width)
            
            let v = UIView(frame: viewFrame)
            v.backgroundColor = UIColor.IOBTintColor
            return v
        })
        
        let highlightLayer = ChartPointsTouchHighlightLayer(
            xAxis: xAxis,
            yAxis: yAxis,
            innerFrame: innerFrame,
            chartPoints: IOBPoints,
            tintColor: UIColor.IOBTintColor,
            labelCenterY: chartSettings.top,
            gestureRecognizer: chartPanGestureRecognizer
        )
        
        let layers: [ChartLayer?] = [
            gridLayer,
            xAxis,
            yAxis,
            zeroGuidelineLayer,
            highlightLayer,
            IOBArea,
            IOBLine,
            ]
        
        return Chart(frame: frame, layers: layers.flatMap { $0 })
    }
}


/*
 Here we extend ChartPointsTouchHighlightLayer to contain its initialization
 */
private extension ChartPointsTouchHighlightLayer {
    
    convenience init(
        xAxis: ChartAxisLayer,
        yAxis: ChartAxisLayer,
        innerFrame: CGRect,
        chartPoints: [T],
        tintColor: UIColor,
        labelCenterY: CGFloat = 0,
        gestureRecognizer: UIPanGestureRecognizer? = nil
        ) {
        self.init(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, gestureRecognizer: gestureRecognizer,
                  modelFilter: { (screenLoc, chartPointModels) -> ChartPointLayerModel<T>? in
                    if let index = chartPointModels.map({ $0.screenLoc.x }).findClosestElementIndexToValue(screenLoc.x) {
                        return chartPointModels[index]
                    } else {
                        return nil
                    }
        },
                  viewGenerator: { (chartPointModel, layer, chart) -> U? in
                    let containerView = U(frame: chart.view.bounds)
                    
                    let xAxisOverlayView = UIView(frame: xAxis.rect.offsetBy(dx: 0, dy: 1))
                    xAxisOverlayView.backgroundColor = UIColor.white
                    xAxisOverlayView.isOpaque = true
                    containerView.addSubview(xAxisOverlayView)
                    
                    let point = ChartPointEllipseView(center: chartPointModel.screenLoc, diameter: 16)
                    point.fillColor = tintColor.withAlphaComponent(0.5)
                    containerView.addSubview(point)
                    
                    if let text = chartPointModel.chartPoint.y.labels.first?.text {
                        let label = UILabel()
                        if #available(iOS 9.0, *) {
                            label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: UIFontWeightBold)
                        } else {
                            label.font = UIFont.systemFont(ofSize: 15)
                        }
                        
                        label.text = text
                        label.textColor = tintColor
                        label.textAlignment = .center
                        label.sizeToFit()
                        label.frame.size.height += 4
                        label.frame.size.width += label.frame.size.height / 2
                        label.center.y = innerFrame.origin.y - 1
                        label.center.x = chartPointModel.screenLoc.x
                        label.frame.origin.x = min(max(label.frame.origin.x, innerFrame.origin.x), innerFrame.maxX - label.frame.size.width)
                        label.frame.origin.makeIntegralInPlaceWithDisplayScale(chart.view.traitCollection.displayScale)
                        label.layer.borderColor = tintColor.cgColor
                        label.layer.borderWidth = 1 / chart.view.traitCollection.displayScale
                        label.layer.cornerRadius = label.frame.size.height / 2
                        label.backgroundColor = UIColor.white
                        
                        containerView.addSubview(label)
                    }
                    
                    if let text = chartPointModel.chartPoint.x.labels.first?.text {
                        let label = UILabel()
                        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
                        label.text = text
                        label.textColor = UIColor.secondaryLabelColor
                        label.sizeToFit()
                        label.center = CGPoint(x: chartPointModel.screenLoc.x, y: xAxisOverlayView.center.y)
                        label.frame.origin.makeIntegralInPlaceWithDisplayScale(chart.view.traitCollection.displayScale)
                        
                        containerView.addSubview(label)
                    }
                    
                    return containerView
        }
        )
    }
}


private extension CGPoint {
    /**
     Rounds the coordinates to whole-pixel values
     - parameter scale: The display scale to use. Defaults to the main screen scale.
     */
    mutating func makeIntegralInPlaceWithDisplayScale(_ scale: CGFloat = 0) {
        var scale = scale
        
        // It's possible for scale values retrieved from traitCollection objects to be 0.
        if scale == 0 {
            scale = UIScreen.main.scale
        }
        x = round(x * scale) / scale
        y = round(y * scale) / scale
    }
}


private extension BidirectionalCollection where Index: Strideable, Iterator.Element: Comparable, Index.Stride == Int {
    
    /**
     Returns the insertion index of a new value in a sorted collection
     Based on some helpful responses found at [StackOverflow](http://stackoverflow.com/a/33674192)
     
     - parameter value: The value to insert
     - returns: The appropriate insertion index, between `startIndex` and `endIndex`
     */
    func findInsertionIndexForValue(_ value: Iterator.Element) -> Index {
        var low = startIndex
        var high = endIndex
        
        while low != high {
            let mid = low.advanced(by: low.distance(to: high) / 2)
            
            if self[mid] < value {
                low = mid.advanced(by: 1)
            } else {
                high = mid
            }
        }
        
        return low
    }
}


private extension BidirectionalCollection where Index: Strideable, Iterator.Element: Strideable, Index.Stride == Int {
    /**
     Returns the index of the closest element to a specified value in a sorted collection
     - parameter value: The value to match
     - returns: The index of the closest element, or nil if the collection is empty
     */
    func findClosestElementIndexToValue(_ value: Iterator.Element) -> Index? {
        let upperBound = findInsertionIndexForValue(value)
        
        if upperBound == startIndex {
            if upperBound == endIndex {
                return nil
            }
            return upperBound
        }
        
        let lowerBound = upperBound.advanced(by: -1)
        
        if upperBound == endIndex {
            return lowerBound
        }
        
        if value.distance(to: self[upperBound]) < self[lowerBound].distance(to: value) {
            return upperBound
        }
        
        return lowerBound
    }
}
