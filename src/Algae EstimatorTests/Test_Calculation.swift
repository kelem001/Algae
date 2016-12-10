//
//  Test_Calculation.swift
//  Algae Estimator
//
//  Created by Derek Riley on 12/5/16.
//  Copyright © 2016 Software Engineering. All rights reserved.
//
import UIKit
import XCTest
@testable import Algae_Estimator

class Test_Calculation: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCalculationDirect(){
        let calculations = Calculations(total_chla: Float(5.0), cyano_chla: Float(5.0), Pbot: Float(2.0), surtemp: Float(38.0), bottemp: Float(20.0), depth: Float(3.0), lux: Float(6.0))
        
        let K1 = calculations.getK1()
        let K2 = calculations.getK2()
        XCTAssert(K1 == 250, "K1 correct")
        XCTAssert(K2 == 200, "K2 correct")
    
    }
    
    func testCalculationEstimate(){
        let calculations = Calculations(SD_value: Float(0.5), DO_value: Float(42.0), Pbot: Float(2.0), surtemp: Float(33.0), bottemp: Float(15.0), depth: Float(4.0), lux: Float(7.0), estimate: Bool(true))
        let Total_chla = calculations.total_chla
        let Cyano_chla = calculations.cyano_chla
        XCTAssert(Total_chla > 37 && Total_chla < 38, "Total_chla estimate correct")
        XCTAssert(Cyano_chla > 11 && Total_chla < 12, "Cyano_chla estimate correct")
        
    }
    
}
