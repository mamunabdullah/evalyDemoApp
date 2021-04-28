//
//  TopShopsModel.swift
//  evalyDemoApp
//
//  Created by Abdullah Al Mamun on 28/4/21.
//

import Foundation
struct TopShopsModel : Codable {
    let next : String?
    let previous : String?
    let message : String?
    let data : [Data]?

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
        data = try values.decodeIfPresent([Data].self, forKey: .data)
    }
}

struct Data : Codable {
    let slug : String?
    let contact_number : String?
    let shop_name : String?
    let shop_image : String?
    let logo_image : String?
    let address : String?
    let description : String?
    let approval : Bool?
    let owner_username : String?
    let owner_name : String?
    let owner_number : String?
    let cashback_percentage : Int?
    let score : Int?
    let is_cod_allowed : Bool?

    enum CodingKeys: String, CodingKey {

        case slug = "slug"
        case contact_number = "contact_number"
        case shop_name = "shop_name"
        case shop_image = "shop_image"
        case logo_image = "logo_image"
        case address = "address"
        case description = "description"
        case approval = "approval"
        case owner_username = "owner_username"
        case owner_name = "owner_name"
        case owner_number = "owner_number"
        case cashback_percentage = "cashback_percentage"
        case score = "score"
        case is_cod_allowed = "is_cod_allowed"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        contact_number = try values.decodeIfPresent(String.self, forKey: .contact_number)
        shop_name = try values.decodeIfPresent(String.self, forKey: .shop_name)
        shop_image = try values.decodeIfPresent(String.self, forKey: .shop_image)
        logo_image = try values.decodeIfPresent(String.self, forKey: .logo_image)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        approval = try values.decodeIfPresent(Bool.self, forKey: .approval)
        owner_username = try values.decodeIfPresent(String.self, forKey: .owner_username)
        owner_name = try values.decodeIfPresent(String.self, forKey: .owner_name)
        owner_number = try values.decodeIfPresent(String.self, forKey: .owner_number)
        cashback_percentage = try values.decodeIfPresent(Int.self, forKey: .cashback_percentage)
        score = try values.decodeIfPresent(Int.self, forKey: .score)
        is_cod_allowed = try values.decodeIfPresent(Bool.self, forKey: .is_cod_allowed)
    }

}

