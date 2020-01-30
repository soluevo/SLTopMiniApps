//
//  CurrencyField.swift
//  liveonbank
//
//  Created by Pedro Albuquerque on 11/12/19.
//  Copyright © 2019 LiveOn Solutions. All rights reserved.
//

import UIKit

protocol CurrencyFieldDelegate: class {
    func editing(value: Decimal)
}

class CurrencyField: UITextField {
    var string: String { return text ?? "" }
    var decimal: Decimal {
        return string.digitsInt.decimal /
            Decimal(pow(10, Double(Formatter.currency.maximumFractionDigits)))
    }
    var decimalNumber: NSDecimalNumber { return decimal.number }
    var doubleValue: Double { return decimalNumber.doubleValue }
    var integerValue: Int { return decimalNumber.intValue   }
    let maximum: Decimal = 999_999_999.99
    weak var delegateCurrency: CurrencyFieldDelegate?
    
    private var lastValue: String?
    
    override func willMove(toSuperview newSuperview: UIView?) {
        Formatter.currency.locale = Locale(identifier: "pt_BR")
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        editingChanged()
    }
    
    override func deleteBackward() {
        text = string.digitsInt.dropLast().string
        editingChanged()
    }
    
    func setValue(_ double: Double){
        self.text = String(format: "%.2f", double)
        editingChanged()
    }
    
    @objc func editingChanged(_ textField: UITextField? = nil) {
        guard decimal <= maximum else {
            text = lastValue
            return
        }
        text = Formatter.currency.string(for: decimal)
        lastValue = text
        delegateCurrency?.editing(value: decimal)
    }
}
