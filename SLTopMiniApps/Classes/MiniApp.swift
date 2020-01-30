//
//  MiniApp.swift
//  TopMiniApps
//
//  Created by Pedro Albuquerque on 08/11/19.
//  Copyright © 2019 Soluevo. All rights reserved.
//

import UIKit

public struct SLMiniApp {
    var title: String?
    var icon: UIImage?
    var iconUrl: String?
    var headView: UIViewController?
    var object: Any?
    
    public init(title: String?, iconUrl: String? = nil, icon: UIImage? = nil, headView: UIViewController?, object: Any? = nil) {
        self.title = title
        self.iconUrl = iconUrl
        self.icon = icon
        self.headView = headView
        self.object = object
    }
}
