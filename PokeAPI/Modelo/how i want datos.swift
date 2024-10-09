//
//  how i want datos.swift
//  PokeAPI
//
//  Created by JonathanA on 05/10/22.
//

import Foundation

struct PokemonPaginator2 {
    var results: [Pokemon]
    
    struct Pokemon {
        var name: String
        var id: Int
        var sprites: Sprite
        var types: [PokemonTypeSlot]
        var stats: [Stats]
        var species: Species
    }
    struct PokemonTypeSlot: Decodable, Hashable {
        var slot: Int
        var type: PokemonType
    }

    struct PokemonType: Decodable, Hashable{
        var name: String
    }
}
