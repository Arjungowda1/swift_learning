//
//  review2Details.swift
//  trackPro
//
//  Created by IOSLevel01 on 17/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct review2Details{
    var batchNumber:Int?
    var usn:String?
     var uid:String?
    var objectives:Int?
    var presentation:Int?
    var viva:Int?
    var methodology:Int?
    var progress:Int?
    var total:Int?
    var record:Int?

init()
{
    
}

 init(withdict dict:[String:AnyObject])
{
    batchNumber = dict["Batch"] as? Int ?? 0
    usn = dict["USN"] as? String ?? ""
    objectives = dict["Objectives"] as? Int ?? 0
    presentation = dict["Presentation"] as? Int ?? 0
    viva = dict["VivaMarks"] as? Int ?? 0
    methodology = dict["Methodolgy"] as? Int ?? 0
    progress = dict["Progress"] as? Int ?? 0
    total = dict["Total"] as? Int ?? 0
    record = dict["Record"] as? Int ?? 0
}
}
