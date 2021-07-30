//
//  cStatTableViewCell.swift
//  trackPro
//
//  Created by IOSLevel01 on 09/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class cStatTableViewCell: UITableViewCell {

    @IBOutlet weak var batch: UILabel!
    @IBOutlet weak var submi: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
