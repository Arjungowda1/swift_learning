//
//  slotDetails.swift
//  trackPro
//
//  Created by iOSLevel1 on 16/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct slotDetails{
 
 var id:String?
 var deadlineDate:String?
 var batch:String?
 init()
 {
  
 }
 
 init(withdict dict:[String:AnyObject])
 {
  
  id = dict["deadlineID"] as? String ?? ""
    
  deadlineDate = dict["DeadlineDate"] as? String ?? ""
  batch = dict["Batch"] as? String ?? ""
  
 }
}
