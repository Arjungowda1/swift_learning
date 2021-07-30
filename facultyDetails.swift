//
//  facultyDetails.swift
//  trackPro
//
//  Created by Veena on 03/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct facultyDetails{
 var name:String?
 var mailID:String?
  var branch:String?
  var year:String?
 var role:String?
  var uid:String?
    var batch:Int?
 
 init()
 {
  
 }
 
 
 
 init(withdict dict:[String:AnyObject])
 {
  name = dict["Name"] as? String ?? ""
  mailID = dict["Email"] as? String ?? ""
    branch = dict["Branch"] as? String ?? ""
    
    year = dict["Year"] as? String ?? ""
  role = dict["Role"] as? String ?? ""
    batch = dict["batch"] as? Int ?? 0
 }
}

//let data = ["Name": self.name.text!,"Email": self.mailID.text!,"Branch": self.branch.text!,"Year": self.year.text!,"Role":self.role,"uid":uid] as [String:Any]
