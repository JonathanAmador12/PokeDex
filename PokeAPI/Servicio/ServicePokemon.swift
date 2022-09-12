//
//  ServicePokemon.swift
//  PokeAPI
//
//  Created by JonathanA on 02/09/22.
//

import Foundation

class PokemonService {
    func getPokemon(handler: @escaping (Result<PokemonPaginator, APIError>)->Void){
        var result: Result<PokemonPaginator, APIError>
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")else{
            result = .failure(APIError.badUrl)
            handler(result)
            return
        }
        print("arnol")
        
        var request = URLRequest(url: url)
        print("arnol 2")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<PokemonPaginator, APIError>
            print("arnol 3")
            
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
            print("arnol 4")
            guard let jsonData = data else{
                return
            }
            print("arnol 5")
            guard let pokemonPaginador = try? JSONDecoder().decode(PokemonPaginator.self, from: jsonData) else{
                result = .failure(.badDecode)
                handler(result)
                return
            }
            print("arnol 6")
            result = .success(pokemonPaginador)
            handler(result)
            
        }
        .resume()
        
    }
}
