//
//  ProductDetailViewController.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 29/01/20.
//

import UIKit

@available(iOS 11.0, *)
class ProductDetailViewController: MAModuleController {
    
    var product: ProductModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadComponents()
    }
    
    func loadComponents(){
        
        self.view.backgroundColor = .white
        
        guard let product = self.product else {return}
        
        self.addComponent(view: ProductDetails(product: product))
        self.addComponent(view: ProductPrice(product: product, delegate: self))
    }
    
}

@available(iOS 11.0, *)
extension ProductDetailViewController: MAButtonDelegate {
    func selected(obj: Any?) {
        print("Adiciona no carrinho")
    }
}
