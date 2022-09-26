//
//  CaracterOfPokemon.swift
//  PokeAPI
//
//  Created by JonathanA on 23/09/22.
//

import Foundation

struct EvolutionChain: Decodable {
    var evolutionChain: SourceEvolutionChain
    
    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.evolutionChain = try container.decode(SourceEvolutionChain.self, forKey: .evolutionChain)
    }
    
}

struct SourceEvolutionChain: Decodable {
    var url: String
}
