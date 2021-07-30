//
//  facultyTableViewCell.swift
//  trackPro
//
//  Created by IOSLevel-01 on 02/03/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit

class facultyTableViewCell1: UITableViewCell {

    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var facName: UILabel!
    @IBOutlet weak var facBatch: UILabel!
    @IBOutlet weak var coordinator: UILabel!
    @IBOutlet weak var hod: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
