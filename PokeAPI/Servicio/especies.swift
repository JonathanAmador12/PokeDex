//
//  especies.swift
//  PokeAPI
//
//  Created by JonathanA on 26/09/22.
//

import Foundation

class Especies {
    
    func getEspecies(url: String, handler: @escaping (Result<EvolutionChain,APIError>)-> Void){
        let result: Result<EvolutionChain, APIError>
        guard let url: URL = URL(string: url) else{
            result = .failure(.badUrl)
            handler(result)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<EvolutionChain, APIError>
            
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
            
            guard let evolutionChain = try? JSONDecoder().decode(EvolutionChain.self, from: jsonData) else{
                result = .failure(.badDecode)
                handler(result)
                return
            }
            
            result = .success(evolutionChain)
            handler(result)
            
            
        }.resume()
    }
}
