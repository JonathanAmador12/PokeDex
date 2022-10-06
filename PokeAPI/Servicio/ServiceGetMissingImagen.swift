//
//  ServiceGetMissingImagen.swift
//  PokeAPI
//
//  Created by JonathanA on 03/10/22.
//

import Foundation

class ServiceMissingImage {
    func getMissingImage(name: String, handler: @escaping (Result<Pokemon, APIError>)->Void) {
        var result: Result<Pokemon, APIError>
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)/") else{
            result = .failure(.badUrl)
            handler(result)
            return
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "Get"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Pokemon, APIError>
            
            guard let response = response as? HTTPURLResponse else{
                return
            }
            
            if response.statusCode == 400{
                result = .failure(.badResponse)
                handler(result)
            }
            if response.statusCode == 401{
                result = .failure(.notAutorized)
                handler(result)
            }
            
            guard let jsonData = data else{
                return
            }
            
            do{
                let pokemon: Pokemon = try JSONDecoder().decode(Pokemon.self, from: jsonData)
                result = .success(pokemon)
                handler(result)
            }catch{
                print(error)
                result = .failure(.badDecode)
                handler(result)
            }
            
            
        }.resume()
    }
}
