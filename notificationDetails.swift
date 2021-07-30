//
//  notificationDetails.swift
//  trackPro
//
//  Created by iOSLevel1 on 12/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct notificationDetails{
 
 var text:String?
 var id:String?
 init()
 {
  
 }
 
 
 
 init(withdict dict:[String:AnyObject])
 {
  
  text = dict["Text"] as? String ?? ""
  
  id = dict["NotificationID"] as? String ?? ""
  
 }
}
