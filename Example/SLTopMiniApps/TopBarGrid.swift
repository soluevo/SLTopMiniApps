//
//  TopBarGrid.swift
//  SLTopMiniApps_Example
//
//  Created by Pedro Albuquerque on 29/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

protocol TopBarDelegate: class {
    func changeToGrid()
    func changeToList()
    func filterAction(open: Bool)
}

class TopBarGridList: UIView {
    
    let selectedColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    let unSelectedColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    
    weak var delegate: TopBarDelegate?
    
    var isOpenFilter: Bool = false {
        didSet{
            if isOpenFilter {
                UIView.animate(withDuration: 0.3) {
                    self.arrow.transform = CGAffineTransform(rotationAngle: 3 * .pi/2)
                }
            }else{
                UIView.animate(withDuration: 0.3) {
                    self.arrow.transform = CGAffineTransform(rotationAngle: .pi/2)
                }
            }
        }
    }
    
    lazy var btnList: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.contentVerticalAlignment = .fill
        view.contentHorizontalAlignment = .fill
        view.contentMode = .scaleAspectFit
        view.imageEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        view.addTarget(self, action: #selector(selectList), for: .touchUpInside)
        view.setImage(UIImage(named: "list")?.getInColor(selectedColor), for: .normal)
        return view
    }()
    
    lazy var btnGrid: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.contentVerticalAlignment = .fill
        view.contentHorizontalAlignment = .fill
        view.contentMode = .scaleAspectFit
        view.imageEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        view.addTarget(self, action: #selector(selectGrid), for: .touchUpInside)
        view.setImage(UIImage(named: "grid")?.getInColor(unSelectedColor), for: .normal)
        return view
    }()
    
    lazy var btnFilter: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = #colorLiteral(red: 0.909488342, green: 0.909488342, blue: 0.909488342, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.setTitleColor(.black, for: .normal)
        view.setAttributedTitle(NSAttributedString(string: "A-Z", attributes: [
            NSAttributedStringKey.font : UIFont.avenirHeavy(12),
            NSAttributedStringKey.foregroundColor : unSelectedColor,
        ]), for: .normal)
        view.contentHorizontalAlignment = .left
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 50)
        view.addTarget(self, action: #selector(selectFilter), for: .touchUpInside)
        return view
    }()
    
    lazy var arrow: UIImageView = {
        let obj = UIImageView(frame: .zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFit
        obj.image = #imageLiteral(resourceName: "arrow").getInColor(selectedColor)
        obj.transform = CGAffineTransform(rotationAngle: .pi/2)
        return obj
    }()
    
    init(delegate: UIViewController? = nil) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
        self.delegate = delegate as? TopBarDelegate
        self.loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        
        self.backgroundColor = .white
        
        self.addSubview(btnList)
        btnList.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        btnList.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        btnList.heightAnchor.constraint(equalToConstant: 25).isActive = true
        btnList.widthAnchor.constraint(equalToConstant: 25).isActive = true
        btnList.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        self.addSubview(btnGrid)
        btnGrid.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        btnGrid.leftAnchor.constraint(equalTo: self.btnList.rightAnchor, constant: 20).isActive = true
        btnGrid.heightAnchor.constraint(equalToConstant: 25).isActive = true
        btnGrid.widthAnchor.constraint(equalToConstant: 25).isActive = true
        btnGrid.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        self.addSubview(btnFilter)
        btnFilter.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        btnFilter.leftAnchor.constraint(equalTo: self.btnGrid.rightAnchor, constant: 20).isActive = true
        btnFilter.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        btnFilter.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        self.addSubview(arrow)
        arrow.centerYAnchor.constraint(equalTo: btnFilter.centerYAnchor).isActive = true
        arrow.rightAnchor.constraint(equalTo: self.btnFilter.rightAnchor, constant: -10).isActive = true
        arrow.heightAnchor.constraint(equalToConstant: 15).isActive = true
        arrow.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
    }
    
    @objc func selectList(){
        btnList.setImage(UIImage(named: "list")?.getInColor(selectedColor), for: .normal)
        btnGrid.setImage(UIImage(named: "grid")?.getInColor(unSelectedColor), for: .normal)
        self.delegate?.changeToList()
    }
    
    @objc func selectGrid(){
        btnGrid.setImage(UIImage(named: "grid")?.getInColor(selectedColor), for: .normal)
        btnList.setImage(UIImage(named: "list")?.getInColor(unSelectedColor), for: .normal)
        self.delegate?.changeToGrid()
    }
    
    @objc func selectFilter(){
        self.isOpenFilter = !self.isOpenFilter
        self.delegate?.filterAction(open: isOpenFilter)
    }
}
