//
//  PokeDex.swift
//  PokeAPI
//
//  Created by JonathanA on 02/09/22.
//

import SwiftUI
import Kingfisher

struct PokeDex: View {
    @ObservedObject var pokemonVM = PokemonViewModel()
    
    let formaGrid = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            if pokemonVM.isLoading {
                ProgressView("Cargando...")
                    .scaleEffect(2)
                    .foregroundColor(.white)
                
            }else{
                VStack(spacing: 0) {
                    HStack {
                        Text("PokeDex")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding()
                    .background(Color("primary"))
                    ScrollView {
                        if let pokemon = pokemonVM.pokemonList{
                            LazyVGrid(columns: formaGrid, spacing: 8) {
                                ForEach(pokemon, id: \.self) { pokemon in
                                    VStack(spacing: 30) {
                                        KFImage(pokemonVM.getPokemonImage(name: pokemon.name))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.red)
                                        Text("\(pokemon.name)")
                                    }
                                    .padding(.bottom, 30)
                                    .onAppear{
                                        pokemonVM.loadMoreData(name: pokemon.name)
                                    }
                                    
                                }
                            }
                            
                        }
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity
                    )
                    .background(Color("background"), ignoresSafeAreaEdges: .bottom)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
        }
        .onAppear{
            pokemonVM.getPokemon()
        }
    }
}

struct PokeDex_Previews: PreviewProvider {
    static var previews: some View {
        PokeDex()
            .preferredColorScheme(.light)
    }
}
