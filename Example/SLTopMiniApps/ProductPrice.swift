//
//  ProductPrice.swift
//  SLTopMiniApps_Example
//
//  Created by Pedro Albuquerque on 29/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import AlamofireImage
import Cosmos

class ProductPrice: UIView {
    
    lazy var separator: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    lazy var price: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .red
        view.clipsToBounds = true
        view.textAlignment = .left
        view.numberOfLines = 1
        view.font = .avenirBlack(25)
        return view
    }()
    
    lazy var priceDetail: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .gray
        view.clipsToBounds = true
        view.textAlignment = .left
        view.numberOfLines = 1
        view.font = .avenirHeavy(15)
        return view
    }()
    
    lazy var btnOpen: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.3764705882, green: 0.7921568627, blue: 0.1411764706, alpha: 1)
        view.setTitleColor(.white, for: .normal)
        view.setTitle("ADICIONAR NO CARRINHO", for: .normal)
        view.titleLabel?.font = .avenirHeavy(15)
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.addTarget(self, action: #selector(openAction), for: .touchUpInside)
        return view
    }()
    
    init(delegate: UIViewController? = nil) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
        self.price.text = "R$ 1.299,00"
        self.priceDetail.text = "ou 12x R$ 108,25"
        self.loadSubViews()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
    
        self.addSubview(separator)
        separator.topAnchor.constraint(equalTo: self.topAnchor, constant: 1).isActive = true
        separator.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        separator.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.addSubview(price)
        price.topAnchor.constraint(equalTo: self.separator.bottomAnchor, constant: 10).isActive = true
        price.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        price.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        self.addSubview(priceDetail)
        priceDetail.topAnchor.constraint(equalTo: self.price.bottomAnchor, constant: 5).isActive = true
        priceDetail.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        priceDetail.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        self.addSubview(btnOpen)
        btnOpen.topAnchor.constraint(equalTo: self.priceDetail.bottomAnchor, constant: 20).isActive = true
        btnOpen.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        btnOpen.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        btnOpen.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnOpen.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    @objc func openAction(){
        
    }
}

