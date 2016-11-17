//
//  Reusable.swift
//  My Photos
//
//  Created by Alexey Tyurin on 18/11/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit

protocol Reusable {
    static func nib() -> UINib
    static func reuseIdentifier() -> String
}

extension Reusable {
    static func nib() -> UINib {
        return UINib(nibName:"\(self)", bundle: nil)
    }
    
    static func reuseIdentifier() -> String {
        return "\(self)" + "Identifier"
    }
}
