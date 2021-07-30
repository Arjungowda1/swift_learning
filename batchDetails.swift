//
//  batchDetails.swift
//  trackPro
//
//  Created by IOSLevel01 on 15/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct batchDetails{
 var batchNumber:Int?
 var usn1:String?
 var name1:String?
 var usn2:String?
 var name2:String?

 var usn3:String?
 var name3:String?
 var usn4:String?
 var name4:String?
 var section:String?
 var uid:String?
 
 init()
 {
  
 }
 
 
 
 init(withdict dict:[String:AnyObject])
 {
  batchNumber = dict["BatchNumber"] as? Int ?? 0
  usn1 = dict["USN1"] as? String ?? ""
  name1 = dict["Name1"] as? String ?? ""

  usn2 = dict["USN2"] as? String ?? ""
  name2 = dict["Name2"] as? String ?? ""

  
  usn3 = dict["USN3"] as? String ?? ""
  name3 = dict["Name3"] as? String ?? ""

  usn4 = dict["USN4"] as? String ?? ""
  name4 = dict["Name4"] as? String ?? ""
  section = dict["Section"] as? String ?? ""
 }
}
