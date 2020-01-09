//
//  SamsungViewController.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 11/11/19.
//

import UIKit

@available(iOS 11.0, *)
class SamsungViewController: ModuleController {
    
    override func viewDidLoad() {
        self.title = "Samsung"
        super.viewDidLoad()
        
        let _ = SLTopMiniAppsInterTarget(self, apps: [
            SLMiniApp(title: "Smartphones", icon: getImage(named: "smartphones"), headView: UIViewController()),
            SLMiniApp(title: "TV", icon: getImage(named: "tv"), headView: UIViewController()),
            SLMiniApp(title: "Smartwatches", icon: getImage(named: "watchs"), headView: UIViewController()),
            SLMiniApp(title: "Informática", icon: getImage(named: "informatica"), headView: UIViewController()),
            SLMiniApp(title: "Acessórios", icon: getImage(named: "acessorios"), headView: UIViewController())
        ])
        self.setTopMarging(110)
        
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



