//
//  detailsTableViewCell.swift
//  trackPro
//
//  Created by IOS on 02/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class detailsTableViewCell: UITableViewCell {

    @IBOutlet weak var usn: UILabel!
    @IBOutlet weak var guide: UILabel!
    @IBOutlet weak var section: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
