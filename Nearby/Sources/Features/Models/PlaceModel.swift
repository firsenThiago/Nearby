//
//  PlaceModel.swift
//  Nearby
//
//  Created by Thiago Firsen on 10/12/24.
//

import Foundation

struct Place: Decodable {
    let id: String
    let name: String
    let description: String
    let cupons: Int
    let latitude: Double
    let longitude: Double
    let address: String
    let phone: String
    let cover: String
    let categoryId: String
}
