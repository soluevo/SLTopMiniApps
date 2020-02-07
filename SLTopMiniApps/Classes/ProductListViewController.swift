//
//  ProductListViewController.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 29/01/20.
//

import UIKit
import AlamofireImage

@available(iOS 11.0, *)
class ProductListViewController: MAModuleController {
    
    var products = [ProductModel]()
    var isList = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showLoading()
        ConfigManager.instance.getProducts(completion: { (productsArray) in
            self.hideLoading()
            self.products = productsArray
            self.loadComponents()
        })
    }
    
    func loadComponents(){
        
        self.view.backgroundColor = .white
        
        self.addComponentTop(view: TopBarGridList(delegate: self))
        self.loadGridList()
    }
    
    func loadGridList(){
        self.clearComponents()
        
        if isList {
            self.products.forEach { (product) in
                let list = ProductList(product: product, delegate: self)
                self.addComponent(view: list)
            }
        }else{
            self.products.enumerated().forEach { (product) in
                if (product.offset % 2 == 0) {
                    let left = self.products[product.offset]
                    let leftView = ProductGrid(product: left, delegate: self)
                    var rightView = UIView(frame: CGRect.zero)
                    if (product.offset + 1) < self.products.count {
                        let right = self.products[product.offset + 1]
                        rightView = ProductGrid(product: right, delegate: self)
                    }
                    self.addComponent(view: MASideBySide(left: leftView, right: rightView))
                }
            }
        }
    }
}

@available(iOS 11.0, *)
extension ProductListViewController: TopBarDelegate {
    func changeToGrid() {
        self.isList = false
        self.loadGridList()
    }
    
    func changeToList() {
        self.isList = true
        self.loadGridList()
    }
    
    func filterAction(open: Bool) {
    }
    
}

@available(iOS 11.0, *)
extension ProductListViewController : MAButtonDelegate {
    func selected(obj: Any?) {
        if let product = obj as? ProductModel {
            let vc = ProductDetailViewController()
            vc.product = product
            self.show(vc, sender: self)
        }
    }
}
