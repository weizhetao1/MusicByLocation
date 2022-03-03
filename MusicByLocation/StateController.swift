//
//  StateController.swift
//  MusicByLocation
//
//  Created by Tao, Weizhe (Coll) on 28/02/2022.
//

import Foundation

class StateController: ObservableObject {
    let locationHandler: LocationHandler = LocationHandler()
    let iTunesAdaptor = ITunesAdaptor()
    @Published var artistsByLocation: [String] = []
    @Published var locationAndArtists: String = "" {
        didSet {
            iTunesAdaptor.getArtists(search: locationAndArtists, completion: updateArtistsByLocation)
        }
    }
    
    func findMusic() {
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorisation()
    }
    
    func updateArtistsByLocation(artists: [Artist]?) {
        let names = artists?.map { return $0.name }
        DispatchQueue.main.async {
            self.artistsByLocation = names ?? ["Error finding Artists from your location"]
        }
    }
}
