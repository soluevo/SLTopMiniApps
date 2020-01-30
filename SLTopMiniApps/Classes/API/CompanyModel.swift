//
//  CompanyModel.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 21/01/20.
//

import Foundation
import HandyJSON
//import RealmSwift

class CompanyModel: HandyJSON {
    
    dynamic var id: Int = 0
    dynamic var name: String?
    dynamic var iconUrl: String?
    dynamic var imageUrl: String?
    dynamic var theme: CompanyTheme?
    dynamic var companyFilters: [CompanyFilter]?
    var logo: UIImage?
//    var companyFilters = List<CompanyFilter>()
    
    required init() {}
}

class CompanyFilter: HandyJSON {
    
    dynamic var id: Int = 0
    dynamic var name: String?
    dynamic var imageUrl: String?
    
    required init() {}
}

class CompanyTheme: HandyJSON {
    dynamic var toolbarHex: String?
    dynamic var bottomBarHex: String?
    
    required init() {}
}
