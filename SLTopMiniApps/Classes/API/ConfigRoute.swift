//
//  ConfigRoute.swift
//  SLTopMiniApps
//
//  Created by Pedro Albuquerque on 21/01/20.
//

import Foundation
import Alamofire

enum ConfigRouter: RouterConfig {
    
    case getCompanies
    case getProducts
    
    var endPoint: String {
        switch self {
        case .getCompanies:
            return "companies"
        case .getProducts:
            return "products"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var urlWithParams: String {
        switch self {
        case .getCompanies:
            return ""
        case .getProducts:
            return ""
        }
    }
    
    var params: APIParams {
        return nil
    }
    
    var headers: APIHeaders {
        return [
            "Content-Type": "application/json; charset=UTF-8"
        ]
        
    }
    
}


