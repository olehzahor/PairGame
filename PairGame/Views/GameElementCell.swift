//
//  GameElementCell.swift
//  PairGame
//
//  Created by jjurlits on 4/28/21.
//

import UIKit

class GameElementCell: UICollectionViewCell {
    var isFlipped: Bool = false
    private let backImage = UIImage(named: "element-back")
    
    var animationOptions: UIView.AnimationOptions = [.transitionFlipFromLeft]
    var animationDuration: TimeInterval = 0.3
    
    let imageView: UIImageView = {
        let uiv = UIImageView()
        uiv.contentMode = .scaleAspectFit
        return uiv
    }()
    
    var textLabel: UILabel =  {
        let label = UILabel()
        return label
    }()
    
    func setupHidden(animate: Bool = false) {
        if !animate { imageView.image = backImage }
        else { hideElement() }
    }
    
    func setupOpened(image: UIImage, animate: Bool = false) {
        if !animate { imageView.image = image }
        else { showElement(image) }
    }
    
    func showElement(_ image: UIImage) {
        UIView.transition(with: self, duration: animationDuration, options: animationOptions) {
            self.imageView.image = image
        }
    }
    
    func hideElement() {
        UIView.transition(with: self, duration: animationDuration, options: animationOptions) {
            self.imageView.image = self.backImage
        }
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        imageView.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
