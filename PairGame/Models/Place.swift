//
//  Place.swift
//  PairGame
//
//  Created by jjurlits on 4/29/21.
//

import Foundation

struct PlacesResponse: Codable {
    var places: [Place]
}

struct Place: Codable {
    var image: String
    var city: String
    var country: String
}
