//
//  TopMiniCollection.swift
//  TopMiniApps
//
//  Created by Pedro Albuquerque on 08/11/19.
//  Copyright © 2019 Soluevo. All rights reserved.
//

//
//  TopMiniCollection.swift
//  TopMiniApps
//
//  Created by Pedro Albuquerque on 08/11/19.
//  Copyright © 2019 Soluevo. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger
import SVProgressHUD

@available(iOS 11.0, *)

public var SLTopMiniFirstVC: UIViewController?

@available(iOS 11.0, *)
public func SLTopMiniAppsTarget(_ target: UIViewController) -> UIView? {
    
    NetworkActivityLogger.shared.startLogging()
    NetworkActivityLogger.shared.level = .debug
    
    SLTopMiniFirstVC = target
    let topApps = SLTopMiniApps()
    
    ConfigManager.instance.getCompanies(completion: { (companyArray) in
        var apps = [SLMiniApp]()
        companyArray.forEach{
            apps.append(SLMiniApp(title: $0.name, iconUrl: $0.iconUrl, headView: CompanyViewController(), object: $0))
        }
        topApps.set(apps: apps)
    })
    
    topApps.insertIn(target: target)
    return topApps
}

@available(iOS 11.0, *)
public func SLTopMiniAppsInterTarget(_ target: UIViewController?, apps: [SLMiniApp]?) -> UIView? {
    guard let apps = apps, let target = target else {return nil}
    let stories = SLTopMiniApps(apps)
    stories.insertIn(target: target)
    return stories
}

public func getImage(named: String) -> UIImage {
    let bundle = Bundle(for: SLTopMiniApps.self)
    let bundleURL = bundle.resourceURL?.appendingPathComponent("SLTopMiniApps.bundle")
    let resourceBundle = Bundle(url: bundleURL!)
    guard let image = UIImage(named: named, in: resourceBundle, compatibleWith: nil) else {return UIImage()}
    return image
}

@available(iOS 9.0, *)
class SLTopMiniApps: UIView {
    
    public var miniApps: [SLMiniApp]?
    public var target: UIViewController?
    
    lazy var collection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let obj = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        obj.showsHorizontalScrollIndicator = false
        obj.translatesAutoresizingMaskIntoConstraints = false
        
        obj.register(SLAppMiniCell.self, forCellWithReuseIdentifier: "AppMiniCell")
        obj.backgroundColor = .clear
        return obj
    }()
    
    public init(_ apps: [SLMiniApp]? = nil) {
        super.init(frame: CGRect.zero)
        self.set(apps: apps)
        
        self.layer.zPosition = 1000
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(iOS 11.0, *)
    public func insertIn(target: UIViewController) {
        self.insertToTarget(target)
    }
    
    func set(apps: [SLMiniApp]?) {
        guard let apps = apps else {return}
        self.miniApps = apps
        self.loadSubViews()
        self.collection.reloadData()
    }
    
    @available(iOS 11.0, *)
    private func insertToTarget(_ target: UIViewController){
        self.target = target
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        target.view.addSubview(self)
        self.leftAnchor.constraint(equalTo: target.view.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: target.view.rightAnchor).isActive = true
        self.topAnchor.constraint(equalTo: target.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func loadSubViews(){
        self.collection.removeFromSuperview()
        self.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
        collection.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        collection.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collection.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        collection.heightAnchor.constraint(equalToConstant: 100).isActive = true
        collection.clipsToBounds = true
    }
}

@available(iOS 9.0, *)
extension SLTopMiniApps: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
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
        return CGSize(width: 70, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let miniApp = self.miniApps?[indexPath.row]
        if #available(iOS 11.0, *) {
            if let vc = miniApp?.headView as? CompanyViewController, let object = miniApp?.object as? CompanyModel{
                vc.company = object
                ConfigManager.instance.companySelected = object
                target?.show(vc, sender: self)
            }
            if let vc = miniApp?.headView as? ProductListViewController {
                self.showLoading()
                ConfigManager.instance.getProducts(completion: { (productsArray) in
                    self.hideLoading()
                    vc.products = productsArray
                    self.target?.show(vc, sender: self)
                })
            }
        }
    }
}
