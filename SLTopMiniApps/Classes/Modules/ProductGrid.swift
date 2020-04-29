//
//  ProductGrid.swift
//  SLTopMiniApps_Example
//
//  Created by Pedro Albuquerque on 28/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import AlamofireImage
import Cosmos

class ProductGrid: UIView {
    
    weak var delegate: MAButtonDelegate?
    var object: ProductModel?
    
    lazy var image: UIImageView = {
        let obj = UIImageView(frame: .zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFit
        obj.clipsToBounds = true
        return obj
    }()
    
    lazy var stars: CosmosView = {
        let obj = CosmosView(frame: .zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.settings.totalStars = 5
        obj.settings.starSize = 15
        obj.settings.filledColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        obj.settings.emptyBorderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        obj.settings.filledBorderColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        obj.settings.updateOnTouch = false
        return obj
    }()

    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.clipsToBounds = true
        view.textAlignment = .center
        view.numberOfLines = 3
        view.font = .avenirHeavy(14)
        return view
    }()
    
    lazy var price: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .red
        view.clipsToBounds = true
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = .avenirBlack(22)
        return view
    }()
    
    lazy var priceDetail: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .gray
        view.clipsToBounds = true
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = .avenirHeavy(11)
        return view
    }()
    
    lazy var btnOpen: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.3764705882, green: 0.7921568627, blue: 0.1411764706, alpha: 1)
        view.setTitleColor(.white, for: .normal)
        view.setTitle("ADICIONAR NO CARRINHO", for: .normal)
        view.titleLabel?.font = .avenirHeavy(12)
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.addTarget(self, action: #selector(openAction), for: .touchUpInside)
        return view
    }()
    
    init(product: ProductModel, delegate: UIViewController? = nil) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
        self.object = product
        if let url = URL(string: product.imagePreviewUrl ?? "") {
            self.image.af_setImage(withURL: url)
        }
        self.title.text = product.title
        self.price.text = "R$ \(product.price ?? 0)"
        self.priceDetail.text = "ou em 12x R$ 24,00"
        self.delegate = delegate as? MAButtonDelegate
        self.loadSubViews()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        
        self.addSubview(image)
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        image.heightAnchor.constraint(equalToConstant: 60).isActive = true
        image.widthAnchor.constraint(equalToConstant: 60).isActive = true
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 5).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        self.addSubview(stars)
        stars.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 10).isActive = true
        stars.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stars.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(price)
        price.topAnchor.constraint(equalTo: self.stars.bottomAnchor, constant: 5).isActive = true
        price.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        price.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        price.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.addSubview(priceDetail)
        priceDetail.topAnchor.constraint(equalTo: self.price.bottomAnchor, constant: 5).isActive = true
        priceDetail.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        priceDetail.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        self.addSubview(btnOpen)
        btnOpen.topAnchor.constraint(equalTo: self.priceDetail.bottomAnchor, constant: 10).isActive = true
        btnOpen.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        btnOpen.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        btnOpen.heightAnchor.constraint(equalToConstant: 25).isActive = true
        btnOpen.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    @objc func openAction(){
        self.delegate?.selected(obj: object)
    }
}
