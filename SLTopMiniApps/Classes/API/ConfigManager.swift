//
//  ConfigManager.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 21/01/20.
//

import UIKit

class ConfigManager {
    static let instance = ConfigManager()
    var companies = [CompanyModel]()
    var products = [ProductModel]()
    var companySelected: CompanyModel?
    
    func getCompanies(completion: @escaping ([CompanyModel]) -> Void, error: @escaping (String) -> Void = { (error) in }){
        let route = RouterManager(router: ConfigRouter.getCompanies)
        APIManager.sharedInstance.request(route: route) { (json) in
            let status = json["statusCode"].intValue
            guard status == 200, let results = json["resultValue"].array else {
                error(json["statusMessage"].string ?? APIManager.errorStandard)
                return
            }
            
            self.companies.removeAll()
            results.forEach { result in
                if let repo = CompanyModel.create(json: result) as? CompanyModel {
                    self.companies.append(repo)
                }
            }
            completion(self.companies)
        }
    }
    
    func getProducts(completion: @escaping ([ProductModel]) -> Void, error: @escaping (String) -> Void = { (error) in }){
        let route = RouterManager(router: ConfigRouter.getProducts)
        APIManager.sharedInstance.request(route: route) { (json) in
            let status = json["statusCode"].intValue
            guard status == 200, let results = json["resultValue"].array else {
                error(json["statusMessage"].string ?? APIManager.errorStandard)
                return
            }
            
            self.products.removeAll()
            results.forEach { result in
                if let repo = ProductModel.create(json: result) as? ProductModel {
                    self.products.append(repo)
                }
            }
            completion(self.products)
        }
    }
}

