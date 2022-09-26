//
//  ModeloImage.swift
//  PokeAPI
//
//  Created by JonathanA on 05/09/22.
//

import Foundation

struct Pokemon: Identifiable, Decodable {
    var id: Int
    var name: String
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
