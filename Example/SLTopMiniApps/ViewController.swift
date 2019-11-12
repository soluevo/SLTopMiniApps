//
//  ViewController.swift
//  SLTopMiniApps
//
//  Created by PedroAlbuquerqueLM on 11/08/2019.
//  Copyright (c) 2019 PedroAlbuquerqueLM. All rights reserved.
//

import UIKit
import SLTopMiniApps

class ViewController: UIViewController {

    lazy var icon: UIImageView = {
        let icon = UIImageView(frame: .zero)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        icon.image = #imageLiteral(resourceName: "backgroundTest")
        return icon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SLTopMiniAppsTarget(self)
        SLTopMiniFirstVC = self
        
        self.view.addSubview(icon)
        icon.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        icon.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        icon.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

