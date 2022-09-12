//
//  ServiceImage.swift
//  PokeAPI
//
//  Created by JonathanA on 05/09/22.
//

import Foundation

class ServiceImage {
    func getPokemon(url: URL, handler: @escaping (Result<Pokemon, APIError>)-> Void) {
//        var result : Result<Pokemon, APIError>
        
//        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/" ) else{
//            result = .failure(.badUrl)
//            handler(result)
//            return
//        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Pokemon, APIError>
            
            guard let response = response as? HTTPURLResponse else{
                return
            }
            
            if response.statusCode == 400{
                result = .failure(.badResponse)
                handler(result)
            }
            if response.statusCode ==  401{
                result = .failure(.notAutorized)
                handler(result)
            }
            
            guard let jsonData = data else{
                return
            }
            
            guard let pokemon = try? JSONDecoder().decode(Pokemon.self, from: jsonData) else{
                result = .failure(.badDecode)
                handler(result)
                return
            }
            
            result = .success(pokemon)
            handler(result)
            
        }
        .resume()
        
    }
}
