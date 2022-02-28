//
//  StateController.swift
//  MusicByLocation
//
//  Created by Tao, Weizhe (Coll) on 28/02/2022.
//

import Foundation

class StateController: ObservableObject {
    @Published var locationAndArtists: String = "" {
        didSet {
            getArtists()
        }
    }
    let locationHandler: LocationHandler = LocationHandler()
    
    func findMusic() {
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorisation()
    }
    
    func getArtists() {
        let countryIndex = self.locationAndArtists.lastIndex(of: ":")!
        var country = String(self.locationAndArtists[locationAndArtists.index(countryIndex, offsetBy: 2)..<(self.locationAndArtists[countryIndex...].firstIndex(of: "\n") ?? self.locationAndArtists.endIndex)])
        country = country.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(country)&entity=musicArtist")
        else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let response = self.parseJson(json: data) {
                    let names = response.results.map {
                        return $0.name
                    }
                    
                    DispatchQueue.main.async {
                        self.locationAndArtists = """
                                                  \(self.locationAndArtists)
                                                  Artists: \(names.joined(separator: ", "))
                                                  """
                    }
                }
            }            
        }.resume()
    }
    
    func parseJson(json: Data) -> ArtistResponse? {
        let decoder = JSONDecoder()
        
        if let artistResponse = try? decoder.decode(ArtistResponse.self, from: json) {
            return artistResponse
        } else {
            print("Error decoding JSON")
            return nil
        }
    }
}
