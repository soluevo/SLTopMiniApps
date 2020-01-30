//
//  Utils.swift
//  FBSnapshotTestCase
//
//  Created by Pedro Albuquerque on 10/12/19.
//

import UIKit
import SystemConfiguration

extension UIFont {
    
    var monospacedDigitFont: UIFont {
        let fontDescriptorFeatureSettings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                                              UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]
        let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings]
        let oldFontDescriptor = fontDescriptor
        let newFontDescriptor = oldFontDescriptor.addingAttributes(fontDescriptorAttributes)
        return UIFont(descriptor: newFontDescriptor, size: 0)
    }
    
    
    class func avenirLight(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Light", size: ofSize!)!
    }
    
    class func avenirRegular(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Book", size: ofSize!)!
    }
    
    class func avenirMedium(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Medium", size: ofSize!)!
    }
    
    class func avenirHeavy(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Heavy", size: ofSize!)!
    }
    
    class func avenirBlack(_ ofSize: CGFloat? = 15.0) -> UIFont {
        return UIFont(name: "Avenir-Black", size: ofSize!)!
    }
}

extension Decimal {
    var number: NSDecimalNumber { return NSDecimalNumber(decimal: self) }
    
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}


extension Collection where Element == UInt8 {
    var string: String { return map(String.init).joined() }
    var decimal: Decimal { return Decimal(string: string) ?? 0 }
}

extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}

extension String {
    
    var digitsInt: [UInt8] {
        return map(String.init).compactMap(UInt8.init)
    }
    
    func toDate(format: String = "dd/MM/yyyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func toDateAll(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}

public struct ScreenSize {
    
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLenght = max(ScreenSize.width, ScreenSize.height)
    static let minLenght = min(ScreenSize.width, ScreenSize.height)
    static let isLarge: Bool = ScreenSize.width > 320
}

class HelperDevice {
    
    static func checkConnection() -> Bool {
        
        if isConnectedToNetwork() {
            return true
        }
        print("Sem conexão.")
        return false
    }
    
    static func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}

class Formatter {
    static let currency = NumberFormatter(numberStyle: .currency)
}
