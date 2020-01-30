//
//  SLTopMiniAppsTests.swift
//  SLTopMiniApps_Tests
//
//  Created by Pedro Albuquerque on 09/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import XCTest

@testable import SLTopMiniApps

@available(iOS 11.0, *)
class SLTopMiniAppsTests: XCTestCase {
    
    func testCreateInterMiniApp(){
        let itens = [
            SLMiniApp(title: "Samsung", icon: UIImage(), headView: UIViewController()),
            SLMiniApp(title: "Centauro", icon: UIImage(), headView: UIViewController()),
            SLMiniApp(title: "Iap", icon: UIImage(), headView: UIViewController()),
            SLMiniApp(title: "Nike", icon: UIImage(), headView: UIViewController()),
            SLMiniApp(title: "Shoptime", icon: UIImage(), headView: UIViewController()),
            SLMiniApp(title: "Kanui", icon: UIImage(), headView: UIViewController()),
        ]
        XCTAssertNotNil(SLTopMiniAppsInterTarget(UIViewController(), apps: itens))
    }
    
    func testCreateMiniAppItem(){
        XCTAssertNotNil(SLMiniApp(title: "test", icon: UIImage(), headView: nil))
    }
    
    func testFirstVC(){
        XCTAssertNotNil(SLTopMiniFirstVC)
    }
    
    func testMiniApps(){
        let itens = [
            SLMiniApp(title: "Samsung", icon: UIImage(), headView: UIViewController()),
            SLMiniApp(title: "Centauro", icon: UIImage(), headView: UIViewController()),
            SLMiniApp(title: "Iap", icon: UIImage(), headView: UIViewController()),
            SLMiniApp(title: "Nike", icon: UIImage(), headView: UIViewController()),
            SLMiniApp(title: "Shoptime", icon: UIImage(), headView: UIViewController()),
            SLMiniApp(title: "Kanui", icon: UIImage(), headView: UIViewController())
        ]
        let apps = SLTopMiniAppsInterTarget(UIViewController(), apps: nil) as? SLTopMiniApps
        XCTAssertNotNil(apps?.target)
        XCTAssertNotNil(apps?.miniApps)
    }
}
