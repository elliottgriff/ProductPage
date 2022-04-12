//
//  Product.swift
//  ProductPage
//
//  Created by elliott on 4/11/22.
//

import Foundation

struct Product: Codable {
    var barcode: String
    var description: String
    var image_url: URL
    var name: String
    var id : String
    var retail_price: Int
}
