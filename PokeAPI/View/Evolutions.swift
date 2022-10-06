//
//  Evolutions.swift
//  PokeAPI
//
//  Created by JonathanA on 23/09/22.
//

import SwiftUI
import Kingfisher

struct Evolutions: View {
    var especies: Species
    @EnvironmentObject var pokemonVm: PokemonViewModel
    @ObservedObject var especiesviewModel = EspeciesViewModel()
    
    var body: some View {
        VStack {
            ForEach(especiesviewModel.evolutions, id: \.self) { name in
                HStack{
                    
                    KFImage(
                        pokemonVm.getPokemonImage(name: name)
                    )
                    Spacer()
                    VStack(alignment: .leading, spacing: 10){
                        Text(name)
                    }
                }
                .padding(.horizontal, 90)
                .overlay{
                    RoundedRectangle(cornerRadius: 80)
                        .stroke(style: .init())
                        .padding(.horizontal, 40)
                }

            }
        }
        .onAppear{
            especiesviewModel.getEspeciesVm(url: especies.url)
        }
    }
}

struct Evolutions_Previews: PreviewProvider {
    static var previews: some View {
        
        let pokemonSpecies = Species(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/")
        
        Evolutions(especies: pokemonSpecies)
            .environmentObject(PokemonViewModel())
    }
}
