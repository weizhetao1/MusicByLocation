//
//  Genre.swift
//  MusicByLocation
//
//  Created by Tao, Weizhe (Coll) on 03/03/2022.
//

import Foundation

struct Genre: Codable {
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "primaryGenreName"
    }
}
