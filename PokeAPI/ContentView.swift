//
//  ContentView.swift
//  PokeAPI
//
//  Created by JonathanA on 01/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("primary")
                .ignoresSafeArea()
            PokeDex()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
