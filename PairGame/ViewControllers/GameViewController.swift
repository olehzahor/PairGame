//
//  ViewController.swift
//  PairGame
//
//  Created by jjurlits on 4/28/21.
//

import UIKit

class GameViewController: UIViewController, Storyboarded, Coordinated {
    weak var coordinator: Coordinator?

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet { setupCollectionView() }
    }
    
    private(set) var elements: [Int] = []
    var gameViewModel = GameViewModel(rows: 4, columns: 3)
    var cellSpacing = CGFloat(8)
    var cellSize = CGSize(width: 100, height: 100)
    
    @IBAction func navigateBack(_ sender: Any) {
        coordinator?.navigateBack()
    }
    
    @IBAction func restartGame(_ sender: Any) {
        gameViewModel.startNewGame()
        update()
    }
        
    override func viewDidLayoutSubviews() {
        adjustCellSize()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(GameElementCell.self, forCellWithReuseIdentifier: "GameElementCell")
    }
    
    func updateScoreLabel() {
        scoreLabel.text = gameViewModel.scoreLabelText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func update() {
        collectionView.reloadData()
        updateScoreLabel()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gameViewModel.elements.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameElementCell", for: indexPath) as! GameElementCell
        
        gameViewModel.configure(
            cell: cell,
            element: gameViewModel.elements[indexPath.row])
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard gameViewModel.canMove else { return }
        gameViewModel.selected(at: indexPath.row)
        update()
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    private func adjustCellSize() {
        let columnsCount = CGFloat(gameViewModel.columns)
        let rowsCount = CGFloat(gameViewModel.rows)

        cellSize.width = (collectionView.bounds.size.width - collectionView.contentInset.left - collectionView.contentInset.right - columnsCount * cellSpacing) / columnsCount
        cellSize.height = (collectionView.bounds.size.height - collectionView.contentInset.top - collectionView.contentInset.bottom - rowsCount * cellSpacing) / rowsCount
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        cellSpacing
    }
}
