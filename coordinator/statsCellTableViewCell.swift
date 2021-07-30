//
//  statsCellTableViewCell.swift
//  trackPro
//
//  Created by IOSLevel1 on 03/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class statsCellTableViewCell: UITableViewCell{

    @IBOutlet weak var batch: UILabel!
    @IBOutlet weak var sub: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
