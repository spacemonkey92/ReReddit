//
//  TopicCell.swift
//  ReReddit
//
//  Created by nitin muthyala on 26/6/17.
//  Copyright © 2017 Spaceage Labs. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {
    
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
