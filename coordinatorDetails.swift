//
//  coordinatorDetails.swift
//  trackPro
//
//  Created by IOSLevel-01 on 09/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct coordinatorDetails{
 
 var email:String?
 var section:String?
 var name:String?
 var role:String?
 var uid:String?
 
 init()
 {
  
 }
 
 
 
 init(withdict dict:[String:AnyObject])
 {
  
  email = dict["Email"] as? String ?? ""
  section = dict["Section"] as? String ?? ""
  
  name = dict["Name"] as? String ?? ""
  role = dict["Role"] as? String ?? ""
  
  uid = dict["uid"] as? String ?? ""
  
  
  
 }
}
