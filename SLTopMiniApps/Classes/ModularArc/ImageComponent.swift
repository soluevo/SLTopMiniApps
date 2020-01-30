//
//  ImageComponent.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 11/11/19.
//

import UIKit

class ImageComponent: UIView {
    
    lazy var image: UIImageView = {
        let obj = UIImageView(frame: .zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFit
        obj.clipsToBounds = true
        return obj
    }()
    
    init(image: UIImage) {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = .clear
        self.image.image = image
        self.loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        self.addSubview(image)
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        let height = image.image?.size.height ?? 0
        let width = image.image?.size.width ?? 0
        image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * height/width).isActive = true
    }
}



