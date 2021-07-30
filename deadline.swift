//
//  deadline.swift
//  trackPro
//
//  Created by iOSLevel1 on 16/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct deadline{
 
 var phase:String?
 var id:String?
 var deadlineDate:String?
 init()
 {
  
 }
 
 
 
 init(withdict dict:[String:AnyObject])
 {
  
  phase = dict["Phase"] as? String ?? ""
  
  id = dict["deadlineID"] as? String ?? ""
    
  deadlineDate = dict["DeadlineDate"] as? String ?? ""
  
 }
}
