//
//  SecViewController.swift
//  TopMiniAppsTest
//
//  Created by Pedro Albuquerque on 08/11/19.
//  Copyright © 2019 Soluevo. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class SecViewController: MAModuleController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.loadSubviews()
    }
    
    func loadSubviews(){
        self.addComponentTop(view: TopBarGridList(delegate: self))
        
        self.addComponent(view: ProductDetails(images: [#imageLiteral(resourceName: "CBLogo"), #imageLiteral(resourceName: "backgroundTest"), #imageLiteral(resourceName: "HPLogo")]))
        self.addComponent(view: ProductPrice(delegate: self))
        
        self.addComponent(view: MATitleDescription(title: "Teste", description: NSAttributedString(string: "desc")))
        self.addComponent(view: SLFullBannerSlide(images: [#imageLiteral(resourceName: "CBLogo"), #imageLiteral(resourceName: "backgroundTest"), #imageLiteral(resourceName: "HPLogo")]))
        self.addComponent(view: SLMiddleBannerSlide(images: [#imageLiteral(resourceName: "CBLogo"), #imageLiteral(resourceName: "backgroundTest"), #imageLiteral(resourceName: "HPLogo")]))
        self.addComponent(view: ProductGrid(image: #imageLiteral(resourceName: "CBLogo"), title: "Notebook Lenovo", price: "R$ 2.499,00", priceDetail: "ou 12x R$ 208,25"))
        self.addComponent(view: SideBySideThreeProducts(title: "PRODUTOS MAIS PROCURADOS", left: ProductGrid(image: #imageLiteral(resourceName: "CBLogo"), title: "Notebook Lenovo Core i5-8265U 8GB 1TB Tela 15.6", price: "R$ 2.499,00", priceDetail: "ou 12x R$ 208,25"), center: ProductGrid(image: #imageLiteral(resourceName: "CBLogo"), title: "Notebook Lenovo", price: "R$ 2.499,00", priceDetail: "ou 12x R$ 208,25"), right: ProductGrid(image: #imageLiteral(resourceName: "CBLogo"), title: "Notebook Lenovo", price: "R$ 2.499,00", priceDetail: "ou 12x R$ 208,25")))
    }
}

extension UIImage {
     func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

extension UIImage {
    
    func getInColor(_ color: UIColor) -> UIImage? {
        
        var newImage = self.withRenderingMode(.alwaysTemplate)
        
        UIGraphicsBeginImageContext(newImage.size)
        
        color.set()
        
        newImage.draw(in: CGRect(origin: .zero, size: newImage.size))
        newImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

