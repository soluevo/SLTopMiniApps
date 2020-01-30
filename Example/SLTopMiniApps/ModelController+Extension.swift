//
//  ModelController+Extension.swift
//  liveonbank
//
//  Created by Pedro Albuquerque on 11/12/19.
//  Copyright © 2019 LiveOn Solutions. All rights reserved.
//

//import UIKit
//
//extension MAModuleController {
//    func validTexts() -> Bool {
//        var isValid = true
//        self.componentViews.forEach { sec in
//            sec.components.forEach{ comp in
//                isValid = self.verifyText(vw: comp) ?? isValid
//                if let side = comp as? MASideBySide {
//                    isValid = self.verifyText(vw: side.leftView) ?? isValid
//                    isValid = self.verifyText(vw: side.rightView) ?? isValid
//                }
//            }
//        }
//        return isValid
//    }
//
//    func removeErroTexts() {
//        self.componentViews.forEach { sec in
//            sec.components.forEach{ comp in
//                if let txt = comp as? MATextField {
//                    txt.setError(obs: "", isError: false)
//                }
//                if let side = comp as? MASideBySide {
//                    if let left = side.leftView as? MATextField {
//                        left.setError(obs: "", isError: false)
//                    }
//                    if let right = side.rightView as? MATextField {
//                        right.setError(obs: "", isError: false)
//                    }
//                }
//            }
//        }
//    }
//
//    private func verifyText(vw: UIView) -> Bool? {
//        if let txt = vw as? MATextField {
//            if txt.isRequired {
//                if txt.field.text == "" {
//                    txt.setError(obs: "", isError: true)
//                    return false
//                }else{
//                    txt.setError(obs: "", isError: false)
//                }
//            }
//        }
//        return nil
//    }
//}
