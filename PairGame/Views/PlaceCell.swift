//
//  PlaceCell.swift
//  PairGame
//
//  Created by jjurlits on 4/29/21.
//

import UIKit

class PlaceCell: UITableViewCell {
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
