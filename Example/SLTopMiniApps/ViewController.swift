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
        icon.image = #imageLiteral(resourceName: "unnamed")
        return icon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SLTopMiniAppsWith(target: self, title: "Mais Apps", detail: "Selecione um novo app para acessar.", isReproduce: true, apps: [
            SLMiniApp(title: "Casas Bahia", icon: #imageLiteral(resourceName: "unnamed"), headView: ViewController()),
            SLMiniApp(title: "HP", icon: #imageLiteral(resourceName: "images"), headView: SecViewController()),
            SLMiniApp(title: "Ponto Frio", icon: #imageLiteral(resourceName: "images"), headView: SecViewController()),
            SLMiniApp(title: "Extra", icon: #imageLiteral(resourceName: "images"), headView: SecViewController()),
            SLMiniApp(title: "Ricardo Eletro", icon: #imageLiteral(resourceName: "images"), headView: SecViewController())
        ])
        
        self.view.addSubview(icon)
        icon.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        icon.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        icon.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

