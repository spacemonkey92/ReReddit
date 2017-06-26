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

    var buttonDelegate: ButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func didClickUpButton(_ sender: Any) {
        if let delegate = self.buttonDelegate{
            delegate.didClick(cell: self,action: true)
        }
    }
    @IBAction func didClickDownButton(_ sender: Any) {
        if let delegate = self.buttonDelegate{
            delegate.didClick(cell: self,action: false)
        }
    }


}

protocol ButtonCellDelegate {
    func didClick(cell: TopicCell, action:Bool)
}
