//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Tao, Weizhe (Coll) on 26/02/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var state = StateController()
    
    var body: some View {
        VStack {
            Text(state.locationAndArtists)
                .padding()
            Spacer()
            Button("Find Music", action: {
                state.findMusic()
            })
        }.onAppear(perform: {
            state.requestAccessToLocationData()
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
