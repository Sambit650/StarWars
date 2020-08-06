//
//  PointTableViewCell.swift
//  StarWar
//
//  Created by sambit on 05/08/20.
//  Copyright © 2020 sambit.das. All rights reserved.
//

import UIKit

class PointTableViewCell: UITableViewCell {

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(url : String){
        playerImage.loadImage(Stringurl: url)
    }
}
