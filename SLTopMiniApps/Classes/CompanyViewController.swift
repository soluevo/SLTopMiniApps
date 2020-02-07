//
//  SamsungViewController.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 11/11/19.
//

import UIKit
import AlamofireImage

@available(iOS 11.0, *)
class CompanyViewController: MAModuleController {
    
    var company: CompanyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var apps = [SLMiniApp]()
        ConfigManager.instance.companySelected?.companyFilters?.forEach({ (companyFilter) in
            apps.append(SLMiniApp(title: companyFilter.name, iconUrl: companyFilter.imageUrl, headView: ProductListViewController(), object: companyFilter))
        })
        let _ = SLTopMiniAppsInterTarget(self, apps: apps)
        self.setTopMarging(110)
    }
    
    func loadComponents(){
        
        self.view.backgroundColor = .white
        
        self.addComponent(view: SLMiddleBannerSlide(images: [getImage(named: "banner1"), getImage(named: "banner1"), getImage(named: "banner1")], delegate: self))
        
        self.showLoading()
        ConfigManager.instance.getProducts(completion: { (productsArray) in
            self.hideLoading()
            self.addComponent(view: SideBySideThreeProducts(title: "PRODUTOS MAIS PROCURADOS", left: ProductsBanner(product: productsArray[0], delegate: self), center: ProductsBanner(product: productsArray[1], delegate: self), right: ProductsBanner(product: productsArray[2], delegate: self)))
            
            self.addComponent(view: SideBySideThreeProducts(title: "PRODUTOS MAIS VENDIDOS", left: ProductsBanner(product: productsArray[0], delegate: self), center: ProductsBanner(product: productsArray[0], delegate: self), right: ProductsBanner(product: productsArray[0], delegate: self)))
        })
        
    }
    
}

@available(iOS 11.0, *)
extension CompanyViewController : MAButtonDelegate {
    func selected(obj: Any?) {
        if let product = obj as? ProductModel {
            let vc = ProductDetailViewController()
            vc.product = product
            self.show(vc, sender: self)
        }else {
            self.showLoading()
            ConfigManager.instance.getProducts(completion: { (productsArray) in
                self.hideLoading()
                let vc = ProductListViewController()
                vc.products = productsArray
                self.show(vc, sender: self)
            })
        }
    }
}



