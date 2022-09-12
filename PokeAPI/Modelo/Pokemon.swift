//
//  Pokemon.swift
//  PokeAPI
//
//  Created by JonathanA on 02/09/22.
//

import Foundation

struct PokemonPaginator: Decodable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [Pokemon]
    
    struct Pokemon: Decodable, Hashable {
        var name: String
        var url: String
    }
    
}

