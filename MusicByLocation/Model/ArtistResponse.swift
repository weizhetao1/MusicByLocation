//
//  ArtistResponse.swift
//  MusicByLocation
//
//  Created by Tao, Weizhe (Coll) on 28/02/2022.
//

import Foundation

struct ArtistResponse: Codable {
    var count: Int
    var results: [Artist]
    //var genres: [Genre]
    
    private enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case results
        //case genres
    }
}
