//
//  studentTableViewCell.swift
//  trackPro
//
//  Created by iOSLevel1 on 03/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class studentTableViewCell: UITableViewCell {

    @IBOutlet var section: UILabel!
    @IBOutlet var usn: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var studBatch: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
