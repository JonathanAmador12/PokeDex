//
//  Func Recursiva.swift
//  PokeAPI
//
//  Created by JonathanA on 28/09/22.
//

import Foundation

class EvolutionData {
    
    var evolutionsName: [String] = []
    
    func trasversal(node: EvolutionNode) {
        print(node.species.name)
        // we need to make a stop condicion
        evolutionsName.append(node.species.name)
        // we need to call the funcion again
        
        for evolution in node.evolvesTo {
            trasversal(node: evolution)
        }
    }
}
