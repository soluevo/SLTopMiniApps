//
//  ProductModel.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 29/01/20.
//

import Foundation
import HandyJSON

class ProductModel: HandyJSON {
    
    dynamic var id: Int = 0
    dynamic var title: String?
    dynamic var price: Double?
    dynamic var desc: String?
    dynamic var imagePreviewUrl: String?
    dynamic var pictures: [Pictures]?
    
    required init() {}
}

class Pictures: HandyJSON {
    
    dynamic var id: Int = 0
    dynamic var title: String?
    dynamic var url: String?
    
    required init() {}
}
