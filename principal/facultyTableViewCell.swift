//
//  facultyTableViewCell.swift
//  trackPro
//
//  Created by iOSLevel1 on 03/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class facultyTableViewCell: UITableViewCell {

     @IBOutlet var facultyName: UILabel!
     @IBOutlet var facultyBatch: UILabel!
    @IBOutlet var ID: UILabel!
    @IBOutlet var coordinator: UILabel!
    @IBOutlet var hod: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
