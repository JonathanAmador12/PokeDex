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
    
    var colores: [String:Color] = [
        "electric": Color.yellow,
        "fire": Color.red,
        "normal": Color.pink.opacity(0.5),
        "fighting": Color.cyan,
        "flying": Color.accentColor,
        "poison": Color.purple,
        "ground": Color.brown,
        "rock": Color.gray,
        "bug": Color.green,
        "ghost": Color.purple.opacity(0.5),
        "steel": .gray.opacity(0.5),
        "water": .blue,
        "grass": .green.opacity(0.10),
        "psychic":.purple.opacity(0.15),
        "ice": .blue.opacity(0.1),
        "dragon": .orange,
        "dark": Color.black,
        "fairy": .white.opacity(0.1),
        "unknown": .black.opacity(0.1),
        "shadow": .purple.opacity(0.9)
    ]
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                // button comeback
                HStack {
                    Button {
                        isActive = false
                    } label: {
                        Image(systemName: "arrow.backward")
                            .font(.title)
                    }
                    Spacer()
                }
                .padding(.bottom, 0)
                // view details
                VStack(spacing: 20) {
                    Text(pokemon.name.capitalized)
                        .font(.title3)
                        .fontWeight(.bold)
                    KFImage(URL(string: pokemon.sprites.frontShiny))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                        .background(colores[pokemon.types[0].type.name])
                        .clipShape(Circle())
                    Text("N- \(pokemon.id)")
                        .font(.title3)
                        .fontWeight(.bold)
                    ForEach(pokemon.types, id: \.self) { type in
                        Text(type.type.name.capitalized)
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(
                                        getTypeColor(name: type.type.name),
                                        style: StrokeStyle(
                                            lineWidth: 4,
                                            dash: [4]
                                        )
                                    )
                            )
                    }
                    HStack {
                        VStack(alignment: .leading, spacing: 25){
                            ForEach(pokemon.stats, id: \.self) { stat in
                                HStack {
                                    Text(stat.stat.name.capitalized)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    Spacer()
                                    Text("\(stat.baseStats)")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black, radius: 2)
            }
            .padding(.horizontal, 25)
        }
    }
    func getTypeColor(name: String) -> Color {
        var color: Color = .black
        
        if let colorType = colores[name]{
            color = colorType
        }
        return color
    }
}

struct Details_Previews: PreviewProvider {
    static var previews: some View {
        let pokemon: Pokemon? = getDataFromMoclFile(mockFileNme: "Pikachu")

        Details(isActive: .constant(false), pokemon: pokemon!)
    }
}
