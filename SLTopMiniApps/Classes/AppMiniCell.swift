//
//  AppMiniCell.swift
//  TopMiniApps
//
//  Created by Pedro Albuquerque on 08/11/19.
//  Copyright © 2019 Soluevo. All rights reserved.
//

import UIKit
import AlamofireImage

@available(iOS 8.2, *)
@available(iOS 9.0, *)
class SLAppMiniCell: UICollectionViewCell {
    
    var miniApp: SLMiniApp? {
        didSet{
            self.icon.image = miniApp?.icon
            if let urlStr = miniApp?.iconUrl, let url = URL(string: urlStr) {
                self.icon.af_setImage(withURL: url)
            }
            self.title.text = miniApp?.title
        }
    }
    
    lazy var icon: UIImageView = {
        let icon = UIImageView(frame: .zero)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        return icon
    }()
    
    lazy var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        title.textAlignment = .center
        title.textColor = #colorLiteral(red: 0.6392156863, green: 0.6352941176, blue: 0.631372549, alpha: 1)
        title.numberOfLines = 1
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        
        self.addSubview(icon)
        icon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        icon.layer.cornerRadius = 30
        icon.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        icon.layer.borderWidth = 1
        
        self.addSubview(title)
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        title.topAnchor.constraint(equalTo: self.icon.bottomAnchor, constant: 5).isActive = true
//        title.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

