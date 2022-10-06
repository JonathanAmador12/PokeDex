//
//  especiesViewModel.swift
//  PokeAPI
//
//  Created by JonathanA on 26/09/22.
//

import Foundation

class EspeciesViewModel: ObservableObject {
    @Published var chain: ChainPokemon?
    @Published var evolutions: [String] = []
    
    
    func getEspeciesVm(url: String){
        let especies = Especies()
        especies.getEspecies(url: url) {[weak self] result in
            switch result{
                case .success(let evolutionChain):
                self?.getChainPokemon(url: evolutionChain.evolutionChain.url)
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    func getChainPokemon(url: String) {
        let serviceChainEvolution = ServiceChainEvolution()
        serviceChainEvolution.getChainEvolution(url: url) {[weak self] result in
            switch result{
            case .success(let chainEvolution):
                DispatchQueue.main.async {
                    self?.chain = chainEvolution
                }

                let evolutionData = EvolutionData()
                evolutionData.trasversal(node: chainEvolution.chain)

                DispatchQueue.main.async {
                    self?.evolutions = evolutionData.evolutionsName
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    
}
