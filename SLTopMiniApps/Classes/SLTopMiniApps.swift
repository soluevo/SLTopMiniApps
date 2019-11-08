//
//  TopMiniCollection.swift
//  TopMiniApps
//
//  Created by Pedro Albuquerque on 08/11/19.
//  Copyright © 2019 Soluevo. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)

public func SLTopMiniAppsWith(target: UIViewController, title: String, isReproduce: Bool, apps: [SLMiniApp]) {
    SLTopMiniApps(title: title, isReproduce: isReproduce, apps: apps).insertIn(target: target)
}

@available(iOS 9.0, *)
class SLTopMiniApps: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var miniApps: [SLMiniApp]?
    var target: UIViewController?
    var isReproduce = true
    
    lazy var collection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let obj = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        obj.translatesAutoresizingMaskIntoConstraints = false
        
        obj.register(SLAppMiniCell.self, forCellWithReuseIdentifier: "AppMiniCell")
        obj.backgroundColor = .clear
        return obj
    }()
    
    lazy var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        title.textColor = .white
        title.textAlignment = .center
        return title
    }()
    
    public init(title: String, isReproduce: Bool = true, apps: [SLMiniApp]) {
        super.init(frame: CGRect.zero)
        self.title.text = title
        self.set(apps: apps)
        
        self.alpha = 0
        self.isHidden = true
        
        self.isReproduce = isReproduce
        self.addGestures()
        self.addBlurEffect()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func insertIn(target: UIViewController) {
        self.insertToTarget(target)
    }
    
    func set(apps: [SLMiniApp]?) {
        guard let apps = apps else {return}
        self.miniApps = apps
        self.loadSubViews()
        self.collection.reloadData()
    }
    
    func show(){
        self.isHidden = false
        self.layer.zPosition = CGFloat(self.target?.view.subviews.count ?? 0)
        UIView.animate(withDuration: 1) {
            self.target?.navigationController?.navigationBar.alpha = 0
        }
        UIView.animate(withDuration: 1.5) {
            self.alpha = 1
        }
    }
    
    func hide(){
        UIView.animate(withDuration: 1) {
            self.target?.navigationController?.navigationBar.alpha = 1
        }
        UIView.animate(withDuration: 1.5, animations: {
            self.alpha = 0
        }) { (_) in
            self.isHidden = true
        }
    }
    
    private func insertToTarget(_ target: UIViewController){
        self.target = target
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        target.view.addSubview(self)
        collection.leftAnchor.constraint(equalTo: target.view.leftAnchor).isActive = true
        collection.rightAnchor.constraint(equalTo: target.view.rightAnchor).isActive = true
        collection.topAnchor.constraint(equalTo: target.view.topAnchor, constant: 100).isActive = true
        collection.bottomAnchor.constraint(equalTo: target.view.bottomAnchor).isActive = true
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        target.view.addGestureRecognizer(swipeDown)
    }
    
    private func addBlurEffect(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.insertSubview(blurEffectView, at: 0)
    }
    
    private func addGestures(){
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.addGestureRecognizer(swipeUp)
    }
    
    private func loadSubViews(){
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 60).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        title.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.collection.removeFromSuperview()
        self.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
        collection.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 20).isActive = true
        collection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        collection.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collection.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        let width = CGFloat(UIScreen.main.bounds.width - 100) / 2.0
        collection.heightAnchor.constraint(equalToConstant: width * CGFloat(miniApps?.count ?? 0)/2.0).isActive = true
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .up {
            self.hide()
        }else if gesture.direction == .down {
            self.show()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return miniApps?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppMiniCell", for: indexPath) as? SLAppMiniCell else {return SLAppMiniCell()}
        guard let miniApp = miniApps?[indexPath.row] else {return cell}
        cell.miniApp = miniApp
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(UIScreen.main.bounds.width - 60) / 4.0
        return CGSize(width: width, height: (width))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.hide()
        guard let vc = self.miniApps?[indexPath.row].headView else {return}
        
        if isReproduce {
            SLTopMiniApps(title: self.title.text ?? "", apps: self.miniApps!).insertIn(target: vc)
        }
        self.window?.rootViewController = vc
    }
}



