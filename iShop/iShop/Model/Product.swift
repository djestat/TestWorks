//
//  Product.swift
//  iShop
//
//  Created by Igor on 04/07/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

import Foundation

struct JSONDB: Codable {
    var type: String
    var products: [Product]
    
}

struct Product: Codable {
    var id: Int
    var name: String
    var image: String
    var info: String
    var price: Int
}

