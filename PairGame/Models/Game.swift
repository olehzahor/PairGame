//
//  Game.swift
//  PairGame
//
//  Created by jjurlits on 4/28/21.
//

import Foundation

struct Game {
    private let startScore = 150

    let fieldSize: FieldSize
    private(set) var elements: [Element] = []
    var selectedElementIndex: Int?
    
    var penalty = -10
    var reward = 30
    
    private(set) var score: Int = 0
    
    mutating private func updateScore(with value: Int) {
        score += value
    }
    
    mutating func generateElements() {
        let elementsCount = Int(fieldSize.linearSize / 2)
        
        var elementsValues = Array(0..<elementsCount)
        elementsValues += elementsValues
        elementsValues.shuffle()
        
        elements = elementsValues.enumerated().map { Element(value: $1, index: $0) }
    }
        
    mutating private func handleSameElementSelection(_ elementIndex: Int) {
        elements[elementIndex].setState(.hidden)
        selectedElementIndex = nil
        updateScore(with: penalty)
    }
    
    mutating private func handleNewElementSelection(_ elementIndex: Int) {
        elements[elementIndex].state = .selected
        selectedElementIndex = elementIndex
    }
    
    mutating private func handleMatchSelection(_ elementIndex: Int) {
        guard selectedElementIndex != nil else { return }
        elements[selectedElementIndex!].setState(.opened)
        elements[elementIndex].setState(.opened)
        selectedElementIndex = nil
        updateScore(with: reward)
    }
    
    mutating private func handleMismatchSelection(_ elementIndex: Int) {
        guard selectedElementIndex != nil else { return }
        elements[selectedElementIndex!].setState(.hidden)
        elements[elementIndex].setState(.selected)
        selectedElementIndex = elementIndex
        updateScore(with: penalty)
    }
    
    mutating func select(at elementIndex: Int) {
        if selectedElementIndex == elementIndex {
            handleSameElementSelection(elementIndex)
            return
        }
        
        if selectedElementIndex != nil {
            if elements[selectedElementIndex!].value == elements[elementIndex].value {
                handleMatchSelection(elementIndex)
            } else {
                handleMismatchSelection(elementIndex)
            }
        }
        else {
            handleNewElementSelection(elementIndex)
        }
    }
    
    mutating func reset() {
        generateElements()
        score = startScore
        selectedElementIndex = nil
    }
    
    init(fieldSize: FieldSize) {
        self.fieldSize = fieldSize
        reset()
    }
}

extension Game {
    struct FieldSize {
        let rows: Int
        let columns: Int
        
        var linearSize: Int {
            rows * columns
        }
    }
}

extension Game {
    struct Element: Equatable, Hashable {
        enum State { case hidden, opened, selected }
        var state = State.hidden
        var value: Int
        var index: Int
        
        mutating func setState(_ newState: State) {
            state = newState
        }
    }
}
