//
//  SwiftMask.swift
//  liveonbank
//
//  Created by Pedro Albuquerque on 11/12/19.
//  Copyright © 2019 LiveOn Solutions. All rights reserved.
//

import UIKit

public class SwiftMaskField: UITextField {
    
    private var _mask: String!
    
    
    @IBInspectable public var maskString: String {
        
        get{
            return _mask
        }
        
        set{
            _mask = newValue
        }
        
    }
    
    public func applyFilter(textField: UITextField){
        
        var index = _mask.startIndex
        var textWithMask:String = ""
        var i:Int = 0
        var text:String = textField.text!
        
        if (text.isEmpty){
            return
        }
        
        text = removeMaskCharacters(text: text, withMask: maskString)
        
        while(index != maskString.endIndex){
            
            if(i >= text.count){
                self.text = textWithMask
                break
            }
            
            if("\(maskString[index])" == "N"){ //Only number
                if !isNumber(textToValidate: String(Array(text)[i])){
                    break
                }
                textWithMask = textWithMask + String(Array(text)[i])
                i += 1
            }else if("\(maskString[index])" == "C"){ //Only Characters A-Z, Upper case only
                if(hasSpecialCharacter(searchTerm: String(Array(text)[i]))){
                    break
                }
                
                if (isNumber(textToValidate: String(Array(text)[i]))){
                    break
                }
                textWithMask = textWithMask + String(Array(text)[i]).uppercased()
                i += 1
            }else if("\(maskString[index])" == "c"){ //Only Characters a-z, lower case only
                if(hasSpecialCharacter(searchTerm: String(Array(text)[i]))){
                    break
                }
                
                if (isNumber(textToValidate: String(Array(text)[i]))){
                    break
                }
                textWithMask = textWithMask + String(Array(text)[i]).lowercased()
                i += 1
            }else if("\(maskString[index])" == "X"){ //Only Characters a-Z
                if(hasSpecialCharacter(searchTerm: String(Array(text)[i]))){
                    break
                }
                
                if (isNumber(textToValidate: String(Array(text)[i]))){
                    break
                }
                textWithMask = textWithMask + String(Array(text)[i])
                i += 1
            }else if("\(maskString[index])" == "%"){ //Characters a-Z + Numbers
                if(hasSpecialCharacter(searchTerm: String(Array(text)[i]))){
                    break
                }
                textWithMask = textWithMask + String(Array(text)[i])
                i += 1
            }else if("\(maskString[index])" == "U"){ //Only Characters A-Z + Numbers, Upper case only
                if(hasSpecialCharacter(searchTerm: String(Array(text)[i]))){
                    break
                }
                
                textWithMask = textWithMask + String(Array(text)[i]).uppercased()
                i += 1
            }else if("\(maskString[index])" == "u"){ //Only Characters a-z + Numbers, lower case only
                if(hasSpecialCharacter(searchTerm: String(Array(text)[i]))){
                    break
                }
                
                textWithMask = textWithMask + String(Array(text)[i]).lowercased()
                i += 1
            }else if("\(maskString[index])" == "$"){ //Only Characters a-z + Numbers + Symbols, lower case only
                
                textWithMask = textWithMask + String(Array(text)[i]).lowercased()
                i += 1
            }else if("\(maskString[index])" == "*"){ //Any Character
                textWithMask = textWithMask + String(Array(text)[i])
                i += 1
            }else{
                textWithMask = textWithMask + "\(maskString[index])"
            }
            
            
            index = _mask.index(after: index)
        }
        
        self.text = textWithMask
    }
    
    public func isNumber(textToValidate:String) -> Bool{
        
        let num = Int(textToValidate)
        
        if num != nil {
            return true
        }
        
        return false
    }
    
    public func hasSpecialCharacter(searchTerm:String) -> Bool{
        let regex = try!  NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options())
        
        if regex.firstMatch(in: searchTerm, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, searchTerm.count)) != nil {
            return true
        }
        
        return false
        
    }
    
    public func removeMaskCharacters( text: String, withMask mask:String) -> String{
        
        var mask = mask
        var text = text
        mask = mask.replacingOccurrences(of: "X", with: "")
        mask = mask.replacingOccurrences(of: "N", with: "")
        mask = mask.replacingOccurrences(of: "C", with: "")
        mask = mask.replacingOccurrences(of: "c", with: "")
        mask = mask.replacingOccurrences(of: "U", with: "")
        mask = mask.replacingOccurrences(of: "u", with: "")
        mask = mask.replacingOccurrences(of: "*", with: "")
        
        var index = mask.startIndex
        
        while(index != mask.endIndex){
            text = text.replacingOccurrences(of: "\(mask[index])", with: "")
            index = mask.index(after: index)
            //            index = index.successor()
        }
        
        return text
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Apply the delegate // not needed
        //delegate = self
        
        addObserver(self, forKeyPath: "text", options: NSKeyValueObservingOptions(), context: nil)
        
        self.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        //print("textFieldDidChange")
        applyFilter(textField: textField)
    }
    
}

extension SwiftMaskField {
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //        if (keyPath == "text" && object === self ) {
        //
        //            //print(self.text)
        //
        //        }
    }
}
