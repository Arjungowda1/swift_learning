//
//  guideDetails2.swift
//  trackPro
//
//  Created by iOSLevel1 on 15/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct guideDetails2{
 
 var email:String?
 var name:String?
 var role:String?
 var uid:String?
    var batchSec:[guideBatchSec]?
 
 init()
 {
  
 }
 
 
 
 init(withdict dict:[String:AnyObject])
 {
  
  email = dict["Email"] as? String ?? ""
//  batch = dict["BatchNumber"] as? String ?? ""
  
  name = dict["Name"] as? String ?? ""
  role = dict["Role"] as? String ?? ""

    batchSec = dict["batches"] as? [guideBatchSec] ?? []
  uid = dict["uid"] as? String ?? ""
  
  
  
 }
}
