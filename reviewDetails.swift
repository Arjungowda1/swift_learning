//
//  reviewDetails.swift
//  trackPro
//
//  Created by IOSLevel01 on 15/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import Foundation
struct reviewDetails{
 var batchNumber:Int?
 var usn:String?
 var litSurvey:Int?
 var presentation:Int?
 var viva:Int?
 
 var total:Int?
  
 var uid:String?

 init()
 {
  
 }
 
 
 
 init(withdict dict:[String:AnyObject])
 {
  batchNumber = dict["Batch"] as? Int ?? 0
  usn = dict["USN"] as? String ?? ""
  litSurvey = dict["LitSurvey"] as? Int ?? 0

  presentation = dict["Presentation"] as? Int ?? 0
  viva = dict["VivaMarks"] as? Int ?? 0

  
  total = dict["Total"] as? Int ?? 0
    
 }
}
/* i.litSurvey!
 self.presMarks = i.presentation!
 self.vivaVoceMarks = i.viva!
 self.totalMarks = i.total!
*/
