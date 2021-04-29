//
//  GameViewModel.swift
//  PairGame
//
//  Created by jjurlits on 4/29/21.
//

import UIKit

class GameViewModel {
    var game: Game
    
    var rows: Int
    var columns: Int
    
    var elements: [Game.Element] { return game.elements }
    var updatedElements: [Game.Element] = []
    
    var openedElements: [Game.Element] {
        game.elements.filter { $0.state == .opened }
    }
    
    var isWon: Bool {
        openedElements.count == game.elements.count
    }
    
    var isFailed: Bool {
        game.score <= 0
    }
    
    var isReseted: Bool = false
    
    var canMove: Bool {
        !isWon && !isFailed
    }
    
    var scoreLabelText: String {
        if isWon {
            return "You Won!"
        } else if isFailed {
            return "You Lose!"
        } else {
            return "Score: \(game.score)"
        }
    }
        
    func selected(at index: Int) {
        if canMove {
            let oldElements = elements
            game.select(at: index)
            updatedElements = elements.difference(from: oldElements)
            isReseted = false
        }
    }
    
    func image(for element: Game.Element) -> UIImage? {
        return UIImage(named: "element-\(element.value + 1)")
    }
    
    func startNewGame() {
        game.reset()
        isReseted = true
    }
    
    func shouldAnimate(element: Game.Element) -> Bool {
        if isReseted { return true }
        else { return updatedElements.contains(element) &&
            element.state != .opened }
    }
    
    init(rows: Int, columns: Int) {
        game = Game(fieldSize: .init(rows: rows, columns: columns))
        self.rows = rows
        self.columns = columns
    }
}

extension GameViewModel {
    func configure(cell: GameElementCell, element: Game.Element) {
        let animate = shouldAnimate(element: element)
        
        if element.state == .hidden {
            cell.setupHidden(animate: animate)
        } else {
            if let image = image(for: element) {
                cell.setupOpened(image: image, animate: animate)
            }
        }
    }
}
