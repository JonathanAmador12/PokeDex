//
//  Stats.swift
//  PokeAPI
//
//  Created by JonathanA on 18/09/22.
//

import Foundation

struct Stats: Decodable, Hashable {
    var baseStats: Int
    var effort: Int
    var stat: Stat
    
    
    enum CodingKeys: String, CodingKey {
        case baseStats = "base_stat"
        case effort
        case stat
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseStats = try container.decode(Int.self, forKey: .baseStats)
        self.effort = try container.decode(Int.self, forKey: .effort)
        self.stat = try container.decode(Stat.self, forKey: .stat)
    }
    
}

struct Stat: Decodable, Hashable {
    var name: String
}
