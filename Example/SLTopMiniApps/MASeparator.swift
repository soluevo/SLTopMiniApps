//
//  MASeparator.swift
//  liveonbank
//
//  Created by Pedro Albuquerque on 18/12/19.
//  Copyright © 2019 LiveOn Solutions. All rights reserved.
//

import UIKit

class MASeparator: UIView {
    
    lazy var separator: UIView = {
        let sep = UIView(frame: .zero)
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = .black
        sep.alpha = 0.3
        return sep
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
        self.loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        
        self.addSubview(separator)
        separator.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        separator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
    }
}






