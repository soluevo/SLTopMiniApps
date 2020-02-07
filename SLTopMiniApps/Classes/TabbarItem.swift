//
//  TabbarItem.swift
//  bobby-ios
//
//  Created by Pedro Albuquerque on 06/08/19.
//  Copyright © 2019 Soluevo. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class TabBarItem: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let transform = CGAffineTransform.identity
        imageView.transform = transform.scaledBy(x: 1.15, y: 1.15)
        
        textColor = UIColor.gray
        highlightTextColor = UIColor().hexStringToUIColor(hex: ConfigManager.instance.companySelected?.theme?.toolbarHex ?? "")
        iconColor = UIColor.gray
        highlightIconColor = UIColor().hexStringToUIColor(hex: ConfigManager.instance.companySelected?.theme?.toolbarHex ?? "")
        backdropColor = .clear
        highlightBackdropColor = .clear
        
        insets = UIEdgeInsets(top: UIScreen.main.bounds.width * 0.007,
                              left: UIScreen.main.bounds.width * 0.040,
                              bottom: UIScreen.main.bounds.width * 0.007,
                              right: UIScreen.main.bounds.width * 0.040)
        layer.cornerRadius = 4
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func highlightAnimation(animated: Bool, completion: (() -> Void)?) {
        UIView.beginAnimations("small", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = imageView.transform.scaledBy(x: 0.8, y: 0.8)
        imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    override func dehighlightAnimation(animated: Bool, completion: (() -> Void)?) {
        UIView.beginAnimations("big", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = CGAffineTransform.identity
        imageView.transform = transform.scaledBy(x: 1.15, y: 1.15)
        UIView.commitAnimations()
        completion?()
    }
}


