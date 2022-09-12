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
}
