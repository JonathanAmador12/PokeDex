//
//  PokemonViewModel.swift
//  PokeAPI
//
//  Created by JonathanA on 02/09/22.
//

import Foundation

class PokemonViewModel: ObservableObject {
    @Published var pokemonPaginador: PokemonPaginator?
    @Published var pokemos: [Pokemon] = []
    @Published var isLoading: Bool = false
    
    func getPokemon(){
        let pokemonService = PokemonService()
        
        pokemonService.getPokemon {[weak self] result in
            switch result{
            case .success(let pokemonPaginador):
                // we need to iterate the pokkemon list and retrieve each pokemon data
                for pokemon in pokemonPaginador.results {
                    if let url = URL(string: pokemon.url) {
                        self?.getPokemonByURL(url: url)
                    }
                }
                DispatchQueue.main.async {
                    self?.pokemonPaginador = pokemonPaginador
                }
            case .failure(let error):
                print("\(error)")
            }
            
        }
    }
    
    // we need to create a new funcion
    
    func getPokemonByURL(url: URL){
        let service = ServiceImage()
        service.getPokemon(url: url) {[weak self] result in
            switch result{
            case .success(let pokemos):
                DispatchQueue.main.async {
                    self?.pokemos.append(pokemos)
//                    print(self?.pokemon.count)
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    func getPokemonImage(name: String) -> URL?{
        
        var image: URL?
        
        for pokemon in pokemos {
            if pokemon.name == name{
                image = URL(string: pokemon.sprites.frontShiny)
            }
        }
        
        return image
    }
    
}
