//
//  phase2Details.swift
//  trackPro
//
//  Created by IOSLevel01 on 17/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct phase2Details{
var batchNumber:Int?
var usn:String?
 var uid:String?
    
var novelty:Int?
var implementation:Int?
var resultandperformace:Int?
var presentation:Int?
var viva:Int?
var report:Int?
var publication:Int?
var projectdiary:Int?
var total:Int?

init()
{
    
}

 init(withdict dict:[String:AnyObject])
{
    batchNumber = dict["Batch"] as? Int ?? 0
    usn = dict["USN"] as? String ?? ""
    
    novelty = dict["Novelty"] as? Int ?? 0
    implementation = dict["Implementation"] as? Int ?? 0
    resultandperformace = dict["Resultandperformace"] as? Int ?? 0
    presentation = dict["Presentation"] as? Int ?? 0
    viva = dict["VivaMarks"] as? Int ?? 0
    report = dict["Report"] as? Int ?? 0
    publication = dict["Publication"] as? Int ?? 0
    projectdiary = dict["Projectdiary"] as? Int ?? 0
    total = dict["Total"] as? Int ?? 0
}
}
