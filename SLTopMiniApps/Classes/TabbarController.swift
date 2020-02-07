//
//  TabbarController.swift
//  bobby-ios
//
//  Created by Pedro Albuquerque on 06/08/19.
//  Copyright © 2019 Soluevo. All rights reserved.
//

import UIKit
import ESTabBarController_swift

@available(iOS 11.0, *)
class TabBarController: ESTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width - 100, height: 20))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        self.viewControllers = [getMainViewController(),
                                getProductsViewController(),
                                ]
        
        self.delegate = self
        
        self.selectedIndex = 0
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let barColor = UIColor().hexStringToUIColor(hex: ConfigManager.instance.companySelected?.theme?.toolbarHex ?? "")
        self.navigationController?.navigationBar.backgroundColor = barColor
        self.navigationController?.navigationBar.barTintColor = barColor
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        if let url = URL(string: ConfigManager.instance.companySelected?.imageUrl ?? "") {
            let imageView = (self.navigationItem.titleView as! UIImageView)
            imageView.af_setImage(withURL: url)
            imageView.image = imageView.image?.resizeImage(targetSize: CGSize(width: (imageView.image?.size.width ?? 0) * 25 / (imageView.image?.size.height ?? 0), height: 25))
            ConfigManager.instance.companySelected?.logo = (self.navigationItem.titleView as! UIImageView).image
        }
    }
    
    func getMainViewController() -> UIViewController {
        let navController = CompanyViewController()
        navController.tabBarItem = ESTabBarItem.init(TabBarItem(), title: "Início", image: getImage(named: "home").getInColor(.gray), selectedImage: getImage(named: "home").getInColor(UIColor().hexStringToUIColor(hex: ConfigManager.instance.companySelected?.theme?.toolbarHex ?? "")))
        return navController
    }
    
    func getProductsViewController() -> UIViewController {
        let navController = ProductListViewController()
        navController.tabBarItem = ESTabBarItem.init(TabBarItem(), title: "Pesquisas", image: getImage(named: "list").getInColor(.gray), selectedImage: getImage(named: "list").getInColor(UIColor().hexStringToUIColor(hex: ConfigManager.instance.companySelected?.theme?.toolbarHex ?? "")))
        return navController
    }
}

@available(iOS 11.0, *)
extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navController = viewController as? UINavigationController {
            navController.popToRootViewController(animated: false)
        }
    }
}


