//
//  studentDetails.swift
//  trackPro
//
//  Created by Veena on 29/05/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct studentDetails{
 var name:String?
 var mailID:String?
 var usn:String?
 var branch:String?
 var batch:Int?
 var year:String?
 var role:String?
 var section: String?
 var progressReview1:Int?
 var progressReview2:Int?
 var progressPhase1:Int?
 var progressPhase2:Int?
 var uid:String?
 
 init()
 {
  
 }
 
 
 
 init(withdict dict:[String:AnyObject])
 {
  name = dict["Name"] as? String ?? ""
  mailID = dict["Email"] as? String ?? ""
  usn = dict["USN"] as? String ?? ""
  branch = dict["Branch"] as? String ?? ""
  section = dict["Section"] as? String ?? ""
    progressReview1 = dict["ProgressReview1"] as? Int ?? 0
    progressReview2 = dict["ProgressReview2"] as? Int ?? 0
    progressPhase1 = dict["ProgressPhase1"] as? Int ?? 0
    progressPhase2 = dict["ProgressPhase2"] as? Int ?? 0
    batch = dict["Batch"] as? Int ?? 0
  year = dict["Year"] as? String ?? ""
  role = dict["Role"] as? String ?? ""
    uid = dict["uid"] as? String ?? ""
 }
}
//let data = [ "Name": self.name.text!,"Email": self.mailID.text!,"Branch": self.branch.text!,"USN":self.usn.text!,"Year": self.year.text!,"Role":1,"Batch":0,"uid":uid] as [String:Any]

