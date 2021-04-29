//
//  PlacesController.swift
//  PairGame
//
//  Created by jjurlits on 4/29/21.
//

import Foundation

class PlacesControlller {
    private let apiService = ApiService()
    private var url = URL(string: placesUrl)
    var places: [Place] = []
    
    func load(completion: @escaping ([Place]) -> Void) {
        apiService.fetch(url: url) { (result: Result<PlacesResponse, Error>) in
            switch result {
            case .success(let response):
                self.places = response.places
                completion(self.places)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
}
