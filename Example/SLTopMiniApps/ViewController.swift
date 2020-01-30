//
//  ViewController.swift
//  SLTopMiniApps
//
//  Created by PedroAlbuquerqueLM on 11/08/2019.
//  Copyright (c) 2019 PedroAlbuquerqueLM. All rights reserved.
//

import UIKit
import SLTopMiniApps

@available(iOS 11.0, *)
class ViewController: UIViewController {

    lazy var icon: UIImageView = {
        let icon = UIImageView(frame: .zero)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.image = #imageLiteral(resourceName: "backgroundTest")
        return icon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let vw = SLTopMiniAppsTarget(self) else {return}
        self.view.addSubview(icon)
        icon.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        icon.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: vw.bottomAnchor).isActive = true
        icon.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        icon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(click)))
        
        let button = UIButton(frame: CGRect(x: 0, y: 300, width: 100, height: 100))
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.loadNavBar()
    }
    
    func loadNavBar(){
        self.navigationController?.navigationBar.backgroundColor =  UIColor().hexStringToUIColor(hex: "#D92031")
        self.navigationController?.navigationBar.barTintColor = UIColor().hexStringToUIColor(hex: "#D92031")
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width - 100, height: 25))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        self.navigationItem.titleView = imageView
        if let url = URL(string: "https://i.imgur.com/gFWmrFb.png") {
            imageView.af_setImage(withURL: url)
            imageView.image = imageView.image?.resizeImage(targetSize: CGSize(width: (imageView.image?.size.width ?? 0) * 25 / (imageView.image?.size.height ?? 0), height: 25))
        }
    }
    
    @objc func click() {
        self.show(SecViewController(), sender: self)
    }
}


extension UIColor {
   func hexStringToUIColor (hex:String) -> UIColor {
       var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

       if (cString.hasPrefix("#")) {
           cString.remove(at: cString.startIndex)
       }

       if ((cString.count) != 6) {
           return UIColor.gray
       }

       var rgbValue:UInt64 = 0
       Scanner(string: cString).scanHexInt64(&rgbValue)

       return UIColor(
           red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
           green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
           blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
           alpha: CGFloat(1.0)
       )
   }
}
