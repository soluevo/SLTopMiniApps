//
//  ViewController.swift
//  SLTopMiniApps
//
//  Created by PedroAlbuquerqueLM on 11/08/2019.
//  Copyright (c) 2019 PedroAlbuquerqueLM. All rights reserved.
//

import UIKit
import SLTopMiniApps

@available(iOS 11.0, *)
class ViewController: UIViewController {

    lazy var icon: UIImageView = {
        let icon = UIImageView(frame: .zero)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.image = #imageLiteral(resourceName: "backgroundTest")
        return icon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let vw = SLTopMiniAppsTarget(self) else {return}
        self.view.addSubview(icon)
        icon.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        icon.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: vw.bottomAnchor).isActive = true
        icon.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        // needed to clear the text in the back navigation:
        self.navigationItem.title = ""
    }
}

