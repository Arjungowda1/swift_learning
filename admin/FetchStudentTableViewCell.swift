//
//  FetchStudentTableViewCell.swift
//  trackPro
//
//  Created by IOSLevel-01 on 02/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class FetchStudentTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var usn: UILabel!
    @IBOutlet weak var studName: UILabel!
    @IBOutlet weak var section: UILabel!
    @IBOutlet weak var studBatch: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
