//
//  MainViewController.swift
//  PairGame
//
//  Created by jjurlits on 4/29/21.
//

import UIKit

class MainViewController: UIViewController, Storyboarded, Coordinated {
    weak var coordinator: Coordinator?
    
    @IBAction func showGame(_ sender: Any) {
        coordinator?.showGame()
    }
    
    @IBAction func showList(_ sender: Any) {
        coordinator?.showPlaces()
    }
    
    @IBAction func showWebView(_ sender: Any) {
        coordinator?.showWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
