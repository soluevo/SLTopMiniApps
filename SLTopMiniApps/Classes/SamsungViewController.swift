//
//  SamsungViewController.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 11/11/19.
//

import UIKit

class SamsungViewController: ModuleController {
    
    override func viewDidLoad() {
        self.title = "Samsung"
        super.viewDidLoad()
        
        self.loadComponents()
    }
    
    func loadComponents(){
        
        self.view.backgroundColor = .white
        
        self.addComponent(view: ImageComponent(image: getImage(named: "img1")))
        self.addComponent(view: ImageComponent(image: getImage(named: "img2")))
        self.addComponent(view: ImageComponent(image: getImage(named: "img3")))
        self.addComponent(view: ImageComponent(image: getImage(named: "img4")))
    }
    
    
    
}



