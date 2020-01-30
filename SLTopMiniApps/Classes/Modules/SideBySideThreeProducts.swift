//
//  SideBySideThreeProducts.swift
//  SLTopMiniApps_Example
//
//  Created by Pedro Albuquerque on 28/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class SideBySideThreeProducts: UIView {
    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.textColor = .white
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.textAlignment = .center
        return view
    }()
    
    lazy var leftView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var centerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rightView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setLeftView(left: UIView?) {
        guard let view = left else {return}
        view.translatesAutoresizingMaskIntoConstraints = false
        leftView = view
        self.addSubview(leftView)
        leftView.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 10).isActive = true
        leftView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        leftView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        leftView.widthAnchor.constraint(equalToConstant: ScreenSize.width/3).isActive = true
    }
    
    func setCenterView(center: UIView?) {
        guard let view = center else {return}
        view.translatesAutoresizingMaskIntoConstraints = false
        centerView = view
        self.addSubview(centerView)
        centerView.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 10).isActive = true
        centerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        centerView.leftAnchor.constraint(equalTo: self.leftView.rightAnchor).isActive = true
        centerView.widthAnchor.constraint(equalToConstant: ScreenSize.width/3).isActive = true
    }
    
    func setRightView(right: UIView?) {
        guard let view = right else {return}
        view.translatesAutoresizingMaskIntoConstraints = false
        rightView = view
        self.addSubview(rightView)
        rightView.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 10).isActive = true
        rightView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rightView.leftAnchor.constraint(equalTo: self.centerView.rightAnchor).isActive = true
        rightView.widthAnchor.constraint(equalToConstant: ScreenSize.width/3).isActive = true
    }
    
    init(title: String, left: UIView, center: UIView, right: UIView) {
        super.init(frame: CGRect.zero)
        
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.title.text = title.uppercased()
        
        self.addSubview(self.title)
        self.title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.title.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        self.setLeftView(left: left)
        self.setCenterView(center: center)
        self.setRightView(right: right)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


