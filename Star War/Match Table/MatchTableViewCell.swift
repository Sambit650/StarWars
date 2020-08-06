//
//  MatchTableViewCell.swift
//  StarWar
//
//  Created by sambit on 05/08/20.
//  Copyright © 2020 sambit.das. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

    @IBOutlet weak var firstPlayer: UILabel!
    @IBOutlet weak var secondPlayer: UILabel!
    @IBOutlet weak var matchScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
