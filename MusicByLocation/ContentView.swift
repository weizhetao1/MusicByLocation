//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Tao, Weizhe (Coll) on 26/02/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationHandler = LocationHandler()
    
    var body: some View {
        VStack {
            List {
                ForEach(locationHandler.lastKnownLocation.sorted(by: >), id: \.key){ key, value in
                    Text("\(key): \(value)")
                }
            }
            Spacer()
            Button("Find Music", action: {
                locationHandler.requestLocation()
            })
        }.onAppear(perform: { locationHandler.requestAuthorisation() })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
