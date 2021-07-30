
//
//  marksTableViewCell.swift
//  trackPro
//
//  Created by iOSLevel1 on 03/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class marksTableViewCell: UITableViewCell {
    
    @IBOutlet var rev1: UILabel!
    @IBOutlet var rev2: UILabel!
    @IBOutlet var phase1: UILabel!
    @IBOutlet var phase2: UILabel!
    @IBOutlet var phase3: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
