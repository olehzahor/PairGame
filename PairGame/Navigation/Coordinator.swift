//
//  MainCoordinator.swift
//  PairGame
//
//  Created by jjurlits on 4/29/21.
//

import UIKit

protocol Coordinated: class {
    var coordinator: Coordinator? { get set }
}

class Coordinator {
    var firstVC: UIViewController&Coordinated
    var controllers: [UIViewController] = []
    
    private func presentVC(_ vc: UIViewController&Coordinated) {
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        controllers.last?.present(vc, animated: true, completion: nil)
        controllers.append(vc)
    }
    
    func showGame() {
        presentVC(GameViewController.instantiate())
    }
    
    func showPlaces() {
        presentVC(PlacesViewController.instantiate())
    }
    
    func showWebView() {
        presentVC(WebViewController.instantiate())
    }
    
    func navigateBack() {
        controllers.last?.dismiss(animated: true)
        controllers.removeLast()
    }
    
    init() {
        firstVC = MainViewController.instantiate()
        firstVC.coordinator = self
        controllers.append(firstVC)
    }
}
