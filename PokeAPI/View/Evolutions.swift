//
//  Evolutions.swift
//  PokeAPI
//
//  Created by JonathanA on 23/09/22.
//

import SwiftUI

struct Evolutions: View {
    var body: some View {
        VStack {
            HStack{
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 100, height: 100)
                Spacer()
                VStack(alignment: .leading, spacing: 10){
                    Text("number")
                    Text("name of evolution")
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
}

struct Evolutions_Previews: PreviewProvider {
    static var previews: some View {
        Evolutions()
    }
}
