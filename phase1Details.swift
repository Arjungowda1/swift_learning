//
//  phase1Details.swift
//  trackPro
//
//  Created by IOSLevel01 on 17/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct phase1Details{
    var batchNumber:Int?
    var usn:String?
     var uid:String?
     var litSurvey:Int?
    var presentation:Int?
    var viva:Int?
    var methodology:Int?
    var implementation:Int?
    var total:Int?

init()
{
    
}

 init(withdict dict:[String:AnyObject])
{
    batchNumber = dict["Batch"] as? Int ?? 0
    usn = dict["USN"] as? String ?? ""
    litSurvey = dict["LitSurvey"] as? Int ?? 0
    presentation = dict["Presentation"] as? Int ?? 0
    viva = dict["VivaMarks"] as? Int ?? 0
    methodology = dict["Methodolgy"] as? Int ?? 0
    implementation = dict["Implementation"] as? Int ?? 0
    total = dict["Total"] as? Int ?? 0
}
}
