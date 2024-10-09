//
//  ServicePokemon.swift
//  PokeAPI
//
//  Created by JonathanA on 02/09/22.
//

import Foundation

class PokemonService {
    func getPokemon(offset: Int, limit: Int, handler: @escaping (Result<PokemonPaginator, APIError>)->Void){
        var result: Result<PokemonPaginator, APIError>
        
        
        guard var urlComponets = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/") else{
            return
            
        }
        
        let params: [URLQueryItem] = [
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "limit", value: String(limit))
        ]
        urlComponets.queryItems = params
        
        guard let url = urlComponets.url else{
            result = .failure(.badUrl)
            handler(result)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<PokemonPaginator, APIError>
            
            guard let response = response as? HTTPURLResponse else{
                return
            }
            
            if response.statusCode == 400 {
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
            
            guard let pokemonPaginador = try? JSONDecoder().decode(PokemonPaginator.self, from: jsonData) else{
                result = .failure(.badDecode)
                handler(result)
                return
            }
            
            result = .success(pokemonPaginador)
            handler(result)
            
        }
        .resume()
        
    }
}

