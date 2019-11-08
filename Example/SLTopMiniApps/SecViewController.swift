//
//  SecViewController.swift
//  TopMiniAppsTest
//
//  Created by Pedro Albuquerque on 08/11/19.
//  Copyright © 2019 Soluevo. All rights reserved.
//

import UIKit

class SecViewController: UIViewController {
    
    lazy var icon: UIImageView = {
        let icon = UIImageView(frame: .zero)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        icon.image = #imageLiteral(resourceName: "images")
        return icon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(icon)
        icon.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        icon.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        icon.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
