//
//  MiddleBannerSlide.swift
//  SLTopMiniApps_Example
//
//  Created by Pedro Albuquerque on 28/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class SLMiddleBannerSlide: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var images: [UIImage]?
    private var indexOfCellBeforeDragging = 0
    var flowLayout = UICollectionViewFlowLayout()
    
    lazy var collection: UICollectionView = {
        flowLayout.scrollDirection = .horizontal
        
        let obj = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.showsHorizontalScrollIndicator = false
        obj.showsVerticalScrollIndicator = false
        obj.register(FullImageCell.self, forCellWithReuseIdentifier: "fullImageCell")
        obj.backgroundColor = UIColor.white
        return obj
    }()
    init(images: [UIImage]) {
        super.init(frame: CGRect.zero)
        self.images = images
        self.set(images: images)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(images: [UIImage]?) {
        guard let images = images else {return}
        self.images = images
        self.loadSubViews()
    }
    
    private func loadSubViews(){
        self.collection.removeFromSuperview()
        self.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
        collection.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        collection.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collection.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        let width = ScreenSize.width
        collection.heightAnchor.constraint(equalToConstant: width/2.0).isActive = true
        collection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fullImageCell", for: indexPath) as? FullImageCell else {return FullImageCell()}
        let image = images?[indexPath.row]
        cell.image.image = image
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(ScreenSize.width - 40)
        return CGSize(width: width, height: width/2.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedParcel = self.images?[indexPath.row]
        collectionView.reloadData()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
      targetContentOffset.pointee = scrollView.contentOffset
        let pageWidth:Float = Float(self.collection.bounds.width - 40)
        let minSpace:Float = 10.0
        var cellToSwipe:Double = Double(Float((scrollView.contentOffset.x))/Float((pageWidth+minSpace))) + Double(0.5)
        if cellToSwipe < 0 {
            cellToSwipe = 0
        } else if cellToSwipe >= Double(self.images?.count ?? 0) {
            cellToSwipe = Double(self.images?.count ?? 0) - Double(1)
        }
        let indexPath:IndexPath = IndexPath(row: Int(cellToSwipe), section:0)
        self.collection.scrollToItem(at:indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
}

