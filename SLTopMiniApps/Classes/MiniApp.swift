//
//  MiniApp.swift
//  TopMiniApps
//
//  Created by Pedro Albuquerque on 08/11/19.
//  Copyright © 2019 Soluevo. All rights reserved.
//

import UIKit

public struct SLMiniApp {
    var title: String
    var icon: UIImage
    var headView: UIViewController?
    
    public init(title: String, icon: UIImage, headView: UIViewController?) {
        self.title = title
        self.icon = icon
        self.headView = headView
    }
}
