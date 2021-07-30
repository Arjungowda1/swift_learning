//
//  guideDetails.swift
//  trackPro
//
//  Created by iOSLevel1 on 09/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct guideDetails{
 
 var email:String?
 var batch:String?
 var name:String?
 var role:String?
 var uid:String?
 var section:String?
 
 init()
 {
  
 }
 
 
 
 init(withdict dict:[String:AnyObject])
 {
  
  email = dict["Email"] as? String ?? ""
  batch = dict["BatchNumber"] as? String ?? ""
  
  name = dict["Name"] as? String ?? ""
  role = dict["Role"] as? String ?? ""
  section = dict["section"] as? String ?? ""
  uid = dict["uid"] as? String ?? ""
  
  
  
 }
}
