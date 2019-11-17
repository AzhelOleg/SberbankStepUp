//
//  CustomTextField.swift
//  SberbankStepUp
//
//  Created by VadimQw  on 17/11/2019.
//  Copyright © 2019 jorge. All rights reserved.
//

import UIKit

extension UITextField {
    
    public static func logIn(with placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.frame.size = CGSize(width: 200, height: 30)
        textField.borderStyle = .roundedRect
        textField.clearsOnBeginEditing = true
        textField.tintColor = .black
        textField.textAlignment = .center
        textField.placeholder = placeholder
        return textField
    }
    
}
