//
//  TopBrandsModel.swift
//  evalyDemoApp
//
//  Created by Abdullah Al Mamun on 28/4/21.
//

import Foundation
struct TopBrandsModel : Codable {
    let next : String?
    let previous : String?
    let message : String?
    let data : [BrandData]?

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
        data = try values.decodeIfPresent([BrandData].self, forKey: .data)
    }

}

struct BrandData : Codable {
    let id : Int?
    let name : String?
    let approved : Bool?
    let slug : String?
    let brand_type : String?
    let image_url : String?
    let status : String?
    let brand_score : Int?
    let version : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case approved = "approved"
        case slug = "slug"
        case brand_type = "brand_type"
        case image_url = "image_url"
        case status = "status"
        case brand_score = "brand_score"
        case version = "version"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        approved = try values.decodeIfPresent(Bool.self, forKey: .approved)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        brand_type = try values.decodeIfPresent(String.self, forKey: .brand_type)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        brand_score = try values.decodeIfPresent(Int.self, forKey: .brand_score)
        version = try values.decodeIfPresent(Int.self, forKey: .version)
    }

}

