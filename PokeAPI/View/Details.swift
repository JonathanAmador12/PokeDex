//
//  Details.swift
//  PokeAPI
//
//  Created by JonathanA on 15/09/22.
//

import SwiftUI
import Kingfisher

struct Details: View {
    @Binding var isActive: Bool
    var pokemon : Pokemon
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack(spacing: 25) {
                HStack {
                    Button {
                        isActive = false
                    } label: {
                        Image(systemName: "arrow.backward")
                            .font(.title)
                    }
                    Spacer()
                }
                Text(pokemon.name)
                KFImage(URL(string: pokemon.sprites.frontShiny))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text("name of beast")
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct Details_Previews: PreviewProvider {
    static var previews: some View {
        let pokemon: Pokemon? = getDataFromMoclFile(mockFileNme: "Pikachu")

        Details(isActive: .constant(false), pokemon: pokemon!)
    }
}
