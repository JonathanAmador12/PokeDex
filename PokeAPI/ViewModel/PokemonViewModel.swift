//
//  PokemonViewModel.swift
//  PokeAPI
//
//  Created by JonathanA on 02/09/22.
//

import Foundation

class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [PokemonPaginator.Pokemon] = []
    @Published var nameToData: [String : Pokemon] = [:]
    @Published var isLoading: Bool = false
    private var offset: Int = 0
    private var limit: Int = 21
    
    func getPokemon(){
        isLoading = true
        let pokemonService = PokemonService()
        
        pokemonService.getPokemon(offset: offset, limit: limit) {[weak self] result in
            switch result{
            case .success(let pokemonPaginador):
                // we need to iterate the pokkemon list and retrieve each pokemon data
                
                let dispatchGroup = DispatchGroup()
                
                for pokemon in pokemonPaginador.results {
                    if let url = URL(string: pokemon.url) {
                        
                        self?.getPokemonByURL(url: url, dispatchGroud: dispatchGroup)
                        
                    }
                }
                DispatchQueue.main.async {
                    self?.pokemonList.append(contentsOf: pokemonPaginador.results)
                }
                
                dispatchGroup.notify(queue: .main) {
                    self?.isLoading = false
                }
            case .failure(let error):
                print("\(error)")
            }
            
        }
    }
    
    // we need to create a new funcion
    
    func getPokemonByURL(url: URL, dispatchGroud: DispatchGroup){
        dispatchGroud.enter()
        let service = ServiceImage()
        service.getPokemon(url: url) {[weak self] result in
            switch result{
            case .success(let pokemos):
                DispatchQueue.main.async {
                    self?.nameToData[pokemos.name] = pokemos
//                    print(self?.pokemon.count)
                }
            case .failure(let error):
                print("\(error)")
            }
            dispatchGroud.leave()
        }
    }
    
    func getPokemonImage(name: String) -> URL?{
        var image: URL?
        if let pokemon = nameToData[name]{
            image = URL(string: pokemon.sprites.frontShiny)
        }
        
//        for pokemon in pokemos {
//            if pokemon.name == name{
//                image = URL(string: pokemon.sprites.frontShiny)
//            }
//        }
        
        return image
    }
    
    func loadMoreData(name: String) {
        
        let lastPokemon = pokemonList.last?.name
        if pokemonList.count > 0 && lastPokemon == name {
            offset = offset + limit
            getPokemon()
        }
    }
    
    func PokemonDetails(name: String) -> Pokemon? {
        var allPokemon: Pokemon?
        if let pokemon = nameToData[name]{
            allPokemon = pokemon
        }
        return allPokemon
    }
    
}
