//
//  guideBatchSec.swift
//  trackPro
//
//  Created by iOSLevel1 on 15/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct guideBatchSec{

 var batch:String?
 var section:String?
 
 init()
 {
  
 }
 
 
 
 init(withdict dict:[String:AnyObject])
 {
  batch = dict["BatchNumber"] as? String ?? ""
  section = dict["section"] as? String ?? ""
 }
}
