//
//  Stripes.swift
//  PokeAPI
//
//  Created by JonathanA on 05/09/22.
//

import Foundation

struct Sprite: Decodable {
    var frontShiny: String
    
    enum CodingKeys: String, CodingKey {
        case frontShiny = "front_shiny"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        frontShiny = try values.decode(String.self, forKey: .frontShiny)
    }
}
