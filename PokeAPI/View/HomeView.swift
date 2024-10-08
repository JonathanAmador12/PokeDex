//
//  HomeView.swift
//  PokeAPI
//
//  Created by JonathanA on 13/09/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var pokemonVM = PokemonViewModel()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                pokemonVM.getPokemon()
                
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
