//
//  ServiceChainEvolution.swift
//  PokeAPI
//
//  Created by JonathanA on 26/09/22.
//

import Foundation

class ServiceChainEvolution {
    func getChainEvolution(url: String, handler: @escaping (Result<ChainPokemon, APIError>)-> Void){
        var result: Result<ChainPokemon, APIError>
        guard let url = URL(string: url) else{
            result = .failure(.badUrl)
            handler(result)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<ChainPokemon, APIError>
            
            guard let response =  response as? HTTPURLResponse else{
                result = .failure(.badUrl)
                handler(result)
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
            
            do {
                let chainPokemon = try JSONDecoder().decode(ChainPokemon.self, from: jsonData)
                
                result = .success(chainPokemon)
                handler(result)
                
            } catch {
                print(error)
                result = .failure(.badDecode)
                handler(result)
                return
            }

            
        }
        .resume()
    }
}
