//
//  TopProductsModel.swift
//  evalyDemoApp
//
//  Created by Abdullah Al Mamun on 28/4/21.
//

import Foundation
struct TopProductsModel : Codable {
    let next : String?
    let previous : String?
    let message : String?
    let data : [ProductsData]?

    enum CodingKeys: String, CodingKey {

        case next = "next"
        case previous = "previous"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        next = try values.decodeIfPresent(String.self, forKey: .next)
        previous = try values.decodeIfPresent(String.self, forKey: .previous)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([ProductsData].self, forKey: .data)
    }

}
struct ProductsData : Codable {
    let name : String?
    let slug : String?
    let image_urls : [String]?
    let price_type : String?
    let max_price : Int?
    let min_price : Int?
    let min_discounted_price : Int?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case slug = "slug"
        case image_urls = "image_urls"
        case price_type = "price_type"
        case max_price = "max_price"
        case min_price = "min_price"
        case min_discounted_price = "min_discounted_price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        image_urls = try values.decodeIfPresent([String].self, forKey: .image_urls)
        price_type = try values.decodeIfPresent(String.self, forKey: .price_type)
        max_price = try values.decodeIfPresent(Int.self, forKey: .max_price)
        min_price = try values.decodeIfPresent(Int.self, forKey: .min_price)
        min_discounted_price = try values.decodeIfPresent(Int.self, forKey: .min_discounted_price)
    }

}
