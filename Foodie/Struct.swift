//
//  Struct.swift
//  Foodie
//
//  Created by HAIYING WENG on 5/4/19.
//  Copyright © 2019 Hack Challenge. All rights reserved.
//

import Foundation

struct FoodCreate: Encodable {
    let start_time: String
    let description: String
    let title: String
    let location_detail: String
    let end_time: String
    let location: String
    let date: String
    let tags: [String]
    let image: String
    enum CodingKeys: String, CodingKey {
        case start_time = "start_time"
        case description = "description"
        case title = "title"
        case location_detail = "location_detail"
        case end_time = "end_time"
        case location = "location"
        case date = "date"
        case tags = "tags"
        case image = "image"
    }
}

struct Food: Decodable {
    let updated_on: String
    let start_time: String
    let description: String
    let title: String
    let location_detail: String
    let created_on: String
    let end_time: String
    let location: String
    let date: String
    let tags: [String]
    let image: String
    enum CodingKeys: String, CodingKey {
        case updated_on = "updated_on"
        case start_time = "start_time"
        case description = "description"
        case title = "title"
        case location_detail = "location_detail"
        case created_on = "created_on"
        case end_time = "end_time"
        case location = "location"
        case date = "date"
        case tags = "tags"
        case image = "image"
    }
}

struct FoodJSON: Decodable {
    let success: Bool
    let data: [Food]
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case data = "data"
    }
}

struct Result: Decodable {
    let success: Bool
    enum CodingKeys: String, CodingKey {
        case success = "success"
    }
}
