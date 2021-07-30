//
//  displayBatchTableViewCell.swift
//  trackPro
//
//  Created by IOSLevel-01 on 04/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class displayBatchTableViewCell: UITableViewCell {

    @IBOutlet weak var createdUsn: UILabel!
    @IBOutlet weak var createdBatch: UILabel!
    @IBOutlet weak var createdName: UILabel!
    @IBOutlet weak var usn2: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var usn3: UILabel!
    @IBOutlet weak var name3: UILabel!
    @IBOutlet weak var usn4: UILabel!
    @IBOutlet weak var name4: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
