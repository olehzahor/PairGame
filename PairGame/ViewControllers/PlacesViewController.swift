//
//  PlacesViewController.swift
//  PairGame
//
//  Created by jjurlits on 4/29/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class PlacesViewController: UIViewController, Storyboarded, Coordinated {
    weak var coordinator: Coordinator?
        
    var placesController = PlacesControlller()
    
    @IBAction func navigateBack(_ sender: Any) {
        coordinator?.navigateBack()
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesController.load { _ in
            self.tableView.reloadData()
        }
    }
}

extension PlacesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        placesController.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as! PlaceCell
        let place = placesController.places[indexPath.row]
        place.viewModel.configure(cell)
        return cell
    }
}
