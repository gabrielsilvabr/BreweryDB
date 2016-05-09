//
//  Category.swift
//  BreweryDB
//
//  Created by Jake Welton on 5/9/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public class Category {
    public let identifier: Int
    public var name: String?
    
    public init(identifier: Int) {
        self.identifier = identifier
    }
}