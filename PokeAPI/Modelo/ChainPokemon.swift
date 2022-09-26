 //
//  ChainPokemon.swift
//  PokeAPI
//
//  Created by JonathanA on 24/09/22.
//

import Foundation

struct ChainPokemon: Identifiable {
    var id: Int
    var chain: EvolutionNode
}

struct EvolutionNode {
    var evolvesTo: [EvolutionNode]
    var species: PokemonSpeciesNode
    
}

struct PokemonSpeciesNode {
    var name: String
    var url: String
}

