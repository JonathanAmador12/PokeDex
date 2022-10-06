 //
//  ChainPokemon.swift
//  PokeAPI
//
//  Created by JonathanA on 24/09/22.
//

import Foundation

struct ChainPokemon: Identifiable, Decodable {
    var id: Int
    var chain: EvolutionNode
    
    
}

struct EvolutionNode: Decodable {
    var evolvesTo: [EvolutionNode]
    var species: PokemonSpeciesNode
    
    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case species
    }
    
    init(from decoder: Decoder) throws {
        let conteiner = try decoder.container(keyedBy: CodingKeys.self)
        self.evolvesTo = try conteiner.decode([EvolutionNode].self, forKey: .evolvesTo)
        self.species = try conteiner.decode(PokemonSpeciesNode.self, forKey: .species)
    }
    
}

struct PokemonSpeciesNode: Decodable {
    var name: String
    var url: String
}

