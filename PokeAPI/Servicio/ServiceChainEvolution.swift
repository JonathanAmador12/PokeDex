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
        print("serviceChainEvolution1")
        
        var request = URLRequest(url: url)
        print("serviceChainEvolution2")
        
        request.httpMethod = "GET"
        print("serviceChainEvolution3")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<ChainPokemon, APIError>
            print("serviceChainEvolution4")
            guard let response =  response as? HTTPURLResponse else{
                result = .failure(.badUrl)
                handler(result)
                return
            }
            print("serviceChainEvolution5")
            if response.statusCode == 400{
                result = .failure(.badResponse)
                handler(result)
            }
            print("serviceChainEvolution6")
            
            if response.statusCode == 401{
                result = .failure(.notAutorized)
                handler(result)
            }
            print("serviceChainEvolution7")
            
            guard let jsonData = data else{
                return
            }
            print("serviceChainEvolution8")
            do {
                let chainPokemon = try JSONDecoder().decode(ChainPokemon.self, from: jsonData)
                print("serviceChainEvolution9")
                result = .success(chainPokemon)
                handler(result)
                print("serviceChainEvolution10")
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
