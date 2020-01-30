//
//  ProductsBanner.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 29/01/20.
//

import UIKit
import AlamofireImage

protocol MAButtonDelegate: class {
    func selected(obj: Any?)
}

class ProductsBanner: UIView {
    
    weak var delegate: MAButtonDelegate?
    var object: ProductModel?
    
    lazy var image: UIImageView = {
        let obj = UIImageView(frame: .zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFit
        obj.clipsToBounds = true
        return obj
    }()
    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.clipsToBounds = true
        view.textAlignment = .center
        view.numberOfLines = 3
        view.font = .avenirHeavy(12)
        return view
    }()
    
    lazy var price: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .red
        view.clipsToBounds = true
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = .avenirHeavy(12)
        return view
    }()
    
    lazy var priceDetail: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .gray
        view.clipsToBounds = true
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = .avenirHeavy(9)
        return view
    }()
    
    lazy var btnOpen: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.3764705882, green: 0.7921568627, blue: 0.1411764706, alpha: 1)
        view.setTitleColor(.white, for: .normal)
        view.setTitle("ABRIR", for: .normal)
        view.titleLabel?.font = .avenirHeavy(12)
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
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 5).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        self.addSubview(price)
        price.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 5).isActive = true
        price.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        price.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        self.addSubview(priceDetail)
        priceDetail.topAnchor.constraint(equalTo: self.price.bottomAnchor, constant: 5).isActive = true
        priceDetail.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        priceDetail.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        self.addSubview(btnOpen)
        btnOpen.topAnchor.constraint(equalTo: self.priceDetail.bottomAnchor, constant: 10).isActive = true
        btnOpen.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        btnOpen.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        btnOpen.heightAnchor.constraint(equalToConstant: 25).isActive = true
        btnOpen.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
    }
    
    @objc func openAction(){
        self.delegate?.selected(obj: object)
    }
}

