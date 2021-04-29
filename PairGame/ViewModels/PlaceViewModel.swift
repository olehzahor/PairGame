//
//  PlaceViewModel.swift
//  PairGame
//
//  Created by jjurlits on 4/29/21.
//

import Foundation

import UIKit

class PlaceViewModel {
    private var place: Place

    init(place: Place) {
        self.place = place
    }
}

extension PlaceViewModel {
    func configure(_ cell: PlaceCell) {
        if let url = URL(string: place.image) {
            cell.pictureView.downloaded(from: url)
        }
        cell.cityLabel.text = place.city
        cell.countryLabel.text = place.country
    }
}

extension Place {
    var viewModel: PlaceViewModel { return .init(place: self) }
}
