//
//  synopsisDetails.swift
//  trackPro
//
//  Created by IOSLevel01 on 02/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct synopsisDetails{
    var batchNum:String?
    var projTitle:String?
    var abstract:String?
    var domain:String?
    var link:String?
    var coordinatorStatus:String?
    var coordinatorRemarks:String?
    var guideRemarks:String?
    var guideStatus:String?
    var progressSynCoord:Int?
    var progressSynGuide:Int?
    var section:String?
    
    var uid:String?
    
    init()
    {
        
    }
    
    
    
    init(withdict dict:[String:AnyObject])
    {
        batchNum = dict["Batch"] as? String ?? ""
        projTitle = dict["ProjectTitle"] as? String ?? ""
        abstract = dict["Abstract"] as? String ?? ""
        
        domain = dict["Domain"] as? String ?? ""
        link = dict["SynopsisPPT"] as? String ?? ""
        
        uid = dict["ID"] as? String ?? ""
        coordinatorStatus = dict["CoordStatus"] as? String ?? ""
        coordinatorRemarks = dict["CoordRemarks"] as? String ?? ""
        guideStatus = dict["GuideStatus"] as? String ?? ""
        guideRemarks = dict["GuideRemarks"] as? String ?? ""
        progressSynCoord = dict["ProgressSynCoord"] as? Int ?? 0
        progressSynGuide = dict["ProgressSynGuide"] as? Int ?? 0
        section = dict["Section"] as? String ?? ""
    }
}
