//
//  MATitleDescription.swift
//  liveonbank
//
//  Created by Pedro Albuquerque on 11/12/19.
//  Copyright © 2019 LiveOn Solutions. All rights reserved.
//

import UIKit

class MATitleDescription: UIView {
    
    lazy var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .avenirHeavy(21)
        title.textColor = .black
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    lazy var desc: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .avenirRegular(18)
        title.textColor = .black
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    init(title: String, description: NSAttributedString) {
        super.init(frame: CGRect.zero)
        
        self.loadSubViews()
        self.title.text = title
        self.desc.attributedText = description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
//        title.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.addSubview(desc)
        desc.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2).isActive = true
        desc.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        desc.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        desc.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
}
