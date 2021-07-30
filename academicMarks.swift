//
//  academicMarks.swift
//  trackPro
//
//  Created by IOSLevel01 on 25/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct academicMarks{
    var batchNumber:Int?
    var usn:String?
     var uid:String?
    var semFour:Float?
    var semFive: Float?
    var semSix:Float?
    
    init()
    {
        
    }
    init(withdict dict:[String:AnyObject])
    {
        batchNumber = dict["Batch"] as? Int ?? 0
        usn = dict["USN"] as? String ?? ""
        
        semFour = dict["SemFour"] as? Float ?? 0
        semFive = dict["SemFive"] as? Float ?? 0
        semSix = dict["SemSix"] as? Float ?? 0
    }
}
