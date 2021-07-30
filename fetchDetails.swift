
import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class fetchDetails: NSObject {
 let db = Database.database().reference()
 
 func getDetails(userId:String, callback: @escaping ResponseHandlerBlock)  {
  
  
  print("uid in closure = \(userId)")
  
    
  let userdetails_ref = db.child("studentDetails").child(userId).queryOrdered(byChild: "USN")
  var userDetails:[studentDetails] = []
  
  userDetails.removeAll()
  
  userdetails_ref.observe(DataEventType.value) { (snapshot) in
   print("snap = \(snapshot)")
   let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
   //let ref = self.rootRef.child("posts").queryOrderedByChild("date").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in

   if eventDataloc.count > 0
   {
    
    let depatObj = studentDetails(withdict: eventDataloc )
    
    userDetails.append(depatObj)
    
    callback(userDetails as AnyObject, nil)
   }
   else
   {
    callback(eventDataloc as AnyObject, nil)
   }
   
   
  }
  
 }
 
    func getDetails2(userId:String, callback: @escaping ResponseHandlerBlock)  {
          
            
            print("uid in closure = \(userId)")
          
                    
          let userdetails_ref = db.child("studentDetails").child(userId)
          var userDetails:[allUserDetails] = []
            
            userDetails.removeAll()
            
            userdetails_ref.observe(DataEventType.value) { (snapshot) in
              print("snap = \(snapshot)")
              let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
              
              if eventDataloc.count > 0
              {

                      let depatObj = allUserDetails(withDictionary: eventDataloc )
                      
                      userDetails.append(depatObj)
                      
                      callback(userDetails as AnyObject, nil)
                      }
                      else
                      {
                          callback(eventDataloc as AnyObject, nil)
                      }

                      
              }
              
                  }
    
 func getAllStudentDetails(callback: @escaping ResponseHandlerBlock)
 {
  let userdetails_ref = db.child("studentDetails").queryOrdered(byChild: "USN")

  var userDetails:[studentDetails] = []
  userDetails.removeAll()
  
  userdetails_ref.observe(DataEventType.value) { (snapshot) in
   print("snap = \(snapshot)")
   var idKeys:[String]
   let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
   if eventDataloc.count > 0
   {
     print(eventDataloc.keys)
    for i in eventDataloc.keys
    {
    print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
    
     let depatObj = studentDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
    print("DepatObj: \(depatObj)")
    userDetails.append(depatObj)
    }
    callback(userDetails as AnyObject, nil)
   }
   else
   {
    callback(eventDataloc as AnyObject, nil)
   }

   
  }
  
 }
 func getAllFacultyDetails(callback: @escaping ResponseHandlerBlock)
 {
  let userdetails_ref = db.child("facultyDetails").queryOrdered(byChild: "Branch")
  
  var userDetails:[facultyDetails] = []
  userDetails.removeAll()
  
  userdetails_ref.observe(DataEventType.value) { (snapshot) in
   print("snap = \(snapshot)")
   var idKeys:[String]
   let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
   if eventDataloc.count > 0
   {
    print(eventDataloc.keys)
    for i in eventDataloc.keys
    {
     print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
     
     let depatObj = facultyDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
     print("DepatObj: \(depatObj)")
     userDetails.append(depatObj)
    }
    callback(userDetails as AnyObject, nil)
   }
   else
   {
    callback(eventDataloc as AnyObject, nil)
   }
   
   
  }
  
 }
    
    func getCoordinatorDetails(userId:String, callback: @escaping ResponseHandlerBlock)
    {
     let userdetails_ref = db.child("projectCoordDetails").child(userId)

     var userDetails:[coordinatorDetails] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       /*let depatObj = studentDetails(withdict: eventDataloc )
        
        userDetails.append(depatObj)
        print(userDetails) */
        
        let depatObj = coordinatorDetails(withdict: eventDataloc)
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
      
      
     }
     
     
     
     
     /* let userdetails_ref = db.child("studentDetails").child(userId).queryOrdered(byChild: "USN")
      var userDetails:[studentDetails] = []
      
      userDetails.removeAll()
      
      userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      //let ref = self.rootRef.child("posts").queryOrderedByChild("date").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
      
      if eventDataloc.count > 0
      {
      
      let depatObj = studentDetails(withdict: eventDataloc )
      
      userDetails.append(depatObj)
      print(userDetails)
      
      callback(userDetails as AnyObject, nil)
      }
      else
      {
      callback(eventDataloc as AnyObject, nil)
      }
      
      
      }*/
     
    }
    
    func getAllCoordinatorDetails(callback: @escaping ResponseHandlerBlock)
     {
      let userdetails_ref = db.child("projectCoordDetails")
      var userDetails:[coordinatorDetails] = []
      userDetails.removeAll()
      
      userdetails_ref.observe(DataEventType.value) { (snapshot) in
       print("snap = \(snapshot)")
       var idKeys:[String]
       let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
       if eventDataloc.count > 0
       {
        print(eventDataloc.keys)
        for i in eventDataloc.keys
        {
         print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
         
         let depatObj = coordinatorDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
         print("DepatObj: \(depatObj)")
         userDetails.append(depatObj)
        }
        callback(userDetails as AnyObject, nil)
       }
       else
       {
        callback(eventDataloc as AnyObject, nil)
       }
       
       
      }
      
     }
    
    func getAllGuideDetails(callback: @escaping ResponseHandlerBlock)
    {
     let userdetails_ref = db.child("projectGuideDetails")
     var userDetails:[guideDetails2] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       print(eventDataloc.keys)
       for i in eventDataloc.keys
       {
        print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
        
        let depatObj = guideDetails2(withdict: eventDataloc[i] as! [String : AnyObject] )
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       }
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
      
      
     }
     
    }
    
    

//     func getNotificationDetails(userId:String, callback: @escaping ResponseHandlerBlock)
//     {
//      let userdetails_ref = db.child("Notification").child(userId)
//      
//      var userDetails:[notificationDetails] = []
//      userDetails.removeAll()
//      userdetails_ref.observe(DataEventType.value) { (snapshot) in
//       print("snap = \(snapshot)")
//       var idKeys:[String]
//       let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
//       if eventDataloc.count > 0
//       {
//        print(eventDataloc.keys)
//        for i in eventDataloc.keys
//        {
//         print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
//         
//         let depatObj = notificationDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
//         print("DepatObj: \(depatObj)")
//         userDetails.append(depatObj)
//        }
//        callback(userDetails as AnyObject, nil)
//       }
//       else
//       {
//        callback(eventDataloc as AnyObject, nil)
//       }
//       
//       
//      }
//      
//    //  userdetails_ref.observe(DataEventType.value) { (snapshot) in
//    //   print("snap = \(snapshot)")
//    //   var idKeys:[String]
//    //   let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
//    //   if eventDataloc.count > 0
//    //   {
//    //    /*let depatObj = studentDetails(withdict: eventDataloc )
//    //
//    //     userDetails.append(depatObj)
//    //     print(userDetails) */
//    //
//    //    let depatObj = notificationDetails(withdict: eventDataloc)
//    //    print("DepatObj: \(depatObj)")
//    //    userDetails.append(depatObj)
//    //
//    //    callback(userDetails as AnyObject, nil)
//    //   }
//    //   else
//    //   {
//    //    callback(eventDataloc as AnyObject, nil)
//    //   }
//    //
//    //
//    //  }
//      
//      
//      
//      
//      /* let userdetails_ref = db.child("studentDetails").child(userId).queryOrdered(byChild: "USN")
//       var userDetails:[studentDetails] = []
//       
//       userDetails.removeAll()
//       
//       userdetails_ref.observe(DataEventType.value) { (snapshot) in
//       print("snap = \(snapshot)")
//       let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
//       //let ref = self.rootRef.child("posts").queryOrderedByChild("date").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
//       
//       if eventDataloc.count > 0
//       {
//       
//       let depatObj = studentDetails(withdict: eventDataloc )
//       
//       userDetails.append(depatObj)
//       print(userDetails)
//       
//       callback(userDetails as AnyObject, nil)
//       }
//       else
//       {
//       callback(eventDataloc as AnyObject, nil)
//       }
//       
//       
//       }*/
//      
//     }
    func getGuideDetails(userId:String, callback: @escaping ResponseHandlerBlock)
    {
     let userdetails_ref = db.child("projectGuideDetails").child(userId)

     var userDetails:[guideDetails] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       /*let depatObj = studentDetails(withdict: eventDataloc )
        
        userDetails.append(depatObj)
        print(userDetails) */
        
        let depatObj = guideDetails(withdict: eventDataloc)
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
      
      
     }
     
     
     
     
     /* let userdetails_ref = db.child("studentDetails").child(userId).queryOrdered(byChild: "USN")
      var userDetails:[studentDetails] = []
      
      userDetails.removeAll()
      
      userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      //let ref = self.rootRef.child("posts").queryOrderedByChild("date").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
      
      if eventDataloc.count > 0
      {
      
      let depatObj = studentDetails(withdict: eventDataloc )
      
      userDetails.append(depatObj)
      print(userDetails)
      
      callback(userDetails as AnyObject, nil)
      }
      else
      {
      callback(eventDataloc as AnyObject, nil)
      }
      
      
      }*/
     
    }
    
    func getGuideBatches(userId:String, callback: @escaping ResponseHandlerBlock)
    {
        let userdetails_ref = db.child("projectGuideDetails").child(userId).child("batches").queryOrdered(byChild: "BatchNumber")

     var allTheBatches:[guideDetails] = []
     allTheBatches.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       /*let depatObj = studentDetails(withdict: eventDataloc )
        
        userDetails.append(depatObj)
        print(userDetails) */
        for i in eventDataloc.keys
        {
         print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
         
         let depatObj = guideDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
         print("DepatObj: \(depatObj)")
         allTheBatches.append(depatObj)
        }
       callback(allTheBatches as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
      
      
     }
     
     
     
     
     /* let userdetails_ref = db.child("studentDetails").child(userId).queryOrdered(byChild: "USN")
      var userDetails:[studentDetails] = []
      
      userDetails.removeAll()
      
      userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      //let ref = self.rootRef.child("posts").queryOrderedByChild("date").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
      
      if eventDataloc.count > 0
      {
      
      let depatObj = studentDetails(withdict: eventDataloc )
      
      userDetails.append(depatObj)
      print(userDetails)
      
      callback(userDetails as AnyObject, nil)
      }
      else
      {
      callback(eventDataloc as AnyObject, nil)
      }
      
      
      }*/
     
    }
    
    
    func getBatchDetails(callback: @escaping ResponseHandlerBlock)
    {
     let userdetails_ref = db.child("BatchDetails").queryOrdered(byChild: "BatchNumber")
     
     var userDetails:[batchDetails] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       print(eventDataloc.keys)
       for i in eventDataloc.keys
       {
        print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
        
        let depatObj = batchDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       }
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
      
      
     }
     
    }
    
    func getSectionDetails(callback: @escaping ResponseHandlerBlock)
    {
     let userdetails_ref = db.child("BatchDetails").queryOrdered(byChild: "Section")
     
     var userDetails:[batchDetails] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       print(eventDataloc.keys)
       for i in eventDataloc.keys
       {
        print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
        
        let depatObj = batchDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       }
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
      
      
     }
     
    }
    
    func getCoordReview1Marks(callback: @escaping ResponseHandlerBlock)
    {
     let userdetails_ref = db.child("CoordinatorMarks").child("Review1")
     
     var userDetails:[reviewDetails] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       print(eventDataloc.keys)
       for i in eventDataloc.keys
       {
        print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
        
        let depatObj = reviewDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       }
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
      
      
     }
     
    }
    
    func getCoordReview2Marks(callback: @escaping ResponseHandlerBlock)
      {
       let userdetails_ref = db.child("CoordinatorMarks").child("Review2")
       
       var userDetails:[review2Details] = []
       userDetails.removeAll()
       
       userdetails_ref.observe(DataEventType.value) { (snapshot) in
        print("snap = \(snapshot)")
        var idKeys:[String]
        let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
        if eventDataloc.count > 0
        {
         print(eventDataloc.keys)
         for i in eventDataloc.keys
         {
          print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
          
          let depatObj = review2Details(withdict: eventDataloc[i] as! [String : AnyObject] )
          print("DepatObj: \(depatObj)")
          userDetails.append(depatObj)
         }
         callback(userDetails as AnyObject, nil)
        }
        else
        {
         callback(eventDataloc as AnyObject, nil)
        }
        
        
       }
       
      }

 func getCoordPhase1Marks(callback: @escaping ResponseHandlerBlock)
    {
     let userdetails_ref = db.child("CoordinatorMarks").child("Phase1")
     
     var userDetails:[phase1Details] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       print(eventDataloc.keys)
       for i in eventDataloc.keys
       {
        print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
        
        let depatObj = phase1Details(withdict: eventDataloc[i] as! [String : AnyObject] )
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       }
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
      
      
     }
     
    }

    func getCoordPhase2Marks(callback: @escaping ResponseHandlerBlock)
       {
        let userdetails_ref = db.child("CoordinatorMarks").child("Phase2")
        
        var userDetails:[phase2Details] = []
        userDetails.removeAll()
        
        userdetails_ref.observe(DataEventType.value) { (snapshot) in
         print("snap = \(snapshot)")
         var idKeys:[String]
         let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
         if eventDataloc.count > 0
         {
          print(eventDataloc.keys)
          for i in eventDataloc.keys
          {
           print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
           
           let depatObj = phase2Details(withdict: eventDataloc[i] as! [String : AnyObject] )
           print("DepatObj: \(depatObj)")
           userDetails.append(depatObj)
          }
          callback(userDetails as AnyObject, nil)
         }
         else
         {
          callback(eventDataloc as AnyObject, nil)
         }
         
         
        }
        
       }
    
    //Guide wala marks yaha aata hai
    //chilla is a legend
    func getGuideReview1Marks(callback: @escaping ResponseHandlerBlock)
       {
        let userdetails_ref = db.child("GuideMarks").child("Review1")
        
        var userDetails:[reviewDetails] = []
        userDetails.removeAll()
        
        userdetails_ref.observe(DataEventType.value) { (snapshot) in
         print("snap = \(snapshot)")
         var idKeys:[String]
         let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
         if eventDataloc.count > 0
         {
          print(eventDataloc.keys)
          for i in eventDataloc.keys
          {
           print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
           
           let depatObj = reviewDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
           print("DepatObj: \(depatObj)")
           userDetails.append(depatObj)
          }
          callback(userDetails as AnyObject, nil)
         }
         else
         {
          callback(eventDataloc as AnyObject, nil)
         }
         
         
        }
        
       }
       
       func getGuideReview2Marks(callback: @escaping ResponseHandlerBlock)
         {
          let userdetails_ref = db.child("GuideMarks").child("Review2")
          
          var userDetails:[review2Details] = []
          userDetails.removeAll()
          
          userdetails_ref.observe(DataEventType.value) { (snapshot) in
           print("snap = \(snapshot)")
           var idKeys:[String]
           let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
           if eventDataloc.count > 0
           {
            print(eventDataloc.keys)
            for i in eventDataloc.keys
            {
             print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
             
             let depatObj = review2Details(withdict: eventDataloc[i] as! [String : AnyObject] )
             print("DepatObj: \(depatObj)")
             userDetails.append(depatObj)
            }
            callback(userDetails as AnyObject, nil)
           }
           else
           {
            callback(eventDataloc as AnyObject, nil)
           }
           
           
          }
          
         }

    func getGuidePhase1Marks(callback: @escaping ResponseHandlerBlock)
       {
        let userdetails_ref = db.child("GuideMarks").child("Phase1")
        
        var userDetails:[phase1Details] = []
        userDetails.removeAll()
        
        userdetails_ref.observe(DataEventType.value) { (snapshot) in
         print("snap = \(snapshot)")
         var idKeys:[String]
         let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
         if eventDataloc.count > 0
         {
          print(eventDataloc.keys)
          for i in eventDataloc.keys
          {
           print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
           
           let depatObj = phase1Details(withdict: eventDataloc[i] as! [String : AnyObject] )
           print("DepatObj: \(depatObj)")
           userDetails.append(depatObj)
          }
          callback(userDetails as AnyObject, nil)
         }
         else
         {
          callback(eventDataloc as AnyObject, nil)
         }
         
         
        }
        
       }

       func getGuidePhase2Marks(callback: @escaping ResponseHandlerBlock)
          {
           let userdetails_ref = db.child("GuideMarks").child("Phase2")
           
           var userDetails:[phase2Details] = []
           userDetails.removeAll()
           
           userdetails_ref.observe(DataEventType.value) { (snapshot) in
            print("snap = \(snapshot)")
            var idKeys:[String]
            let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
            if eventDataloc.count > 0
            {
             print(eventDataloc.keys)
             for i in eventDataloc.keys
             {
              print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
              
              let depatObj = phase2Details(withdict: eventDataloc[i] as! [String : AnyObject] )
              print("DepatObj: \(depatObj)")
              userDetails.append(depatObj)
             }
             callback(userDetails as AnyObject, nil)
            }
            else
            {
             callback(eventDataloc as AnyObject, nil)
            }
            
            
           }
           
          }
    
    //Faculty wala marks yaha aata hai
    //chilla is a legend
    func getFacultyReview1Marks(callback: @escaping ResponseHandlerBlock)
       {
        let userdetails_ref = db.child("FacultyMarks").child("Review1")
        
        var userDetails:[reviewDetails] = []
        userDetails.removeAll()
        
        userdetails_ref.observe(DataEventType.value) { (snapshot) in
         print("snap = \(snapshot)")
         var idKeys:[String]
         let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
         if eventDataloc.count > 0
         {
          print(eventDataloc.keys)
          for i in eventDataloc.keys
          {
           print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
           
           let depatObj = reviewDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
           print("DepatObj: \(depatObj)")
           userDetails.append(depatObj)
          }
          callback(userDetails as AnyObject, nil)
         }
         else
         {
          callback(eventDataloc as AnyObject, nil)
         }
         
         
        }
        
       }
       
       func getFacultyReview2Marks(callback: @escaping ResponseHandlerBlock)
         {
          let userdetails_ref = db.child("FacultyMarks").child("Review2")
          
          var userDetails:[review2Details] = []
          userDetails.removeAll()
          
          userdetails_ref.observe(DataEventType.value) { (snapshot) in
           print("snap = \(snapshot)")
           var idKeys:[String]
           let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
           if eventDataloc.count > 0
           {
            print(eventDataloc.keys)
            for i in eventDataloc.keys
            {
             print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
             
             let depatObj = review2Details(withdict: eventDataloc[i] as! [String : AnyObject] )
             print("DepatObj: \(depatObj)")
             userDetails.append(depatObj)
            }
            callback(userDetails as AnyObject, nil)
           }
           else
           {
            callback(eventDataloc as AnyObject, nil)
           }
           
           
          }
          
         }

    func getFacultyPhase1Marks(callback: @escaping ResponseHandlerBlock)
       {
        let userdetails_ref = db.child("FacultyMarks").child("Phase1")
        
        var userDetails:[phase1Details] = []
        userDetails.removeAll()
        
        userdetails_ref.observe(DataEventType.value) { (snapshot) in
         print("snap = \(snapshot)")
         var idKeys:[String]
         let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
         if eventDataloc.count > 0
         {
          print(eventDataloc.keys)
          for i in eventDataloc.keys
          {
           print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
           
           let depatObj = phase1Details(withdict: eventDataloc[i] as! [String : AnyObject] )
           print("DepatObj: \(depatObj)")
           userDetails.append(depatObj)
          }
          callback(userDetails as AnyObject, nil)
         }
         else
         {
          callback(eventDataloc as AnyObject, nil)
         }
         
         
        }
        
       }

       func getFacultyPhase2Marks(callback: @escaping ResponseHandlerBlock)
          {
           let userdetails_ref = db.child("FacultyMarks").child("Phase2")
           
           var userDetails:[phase2Details] = []
           userDetails.removeAll()
           
           userdetails_ref.observe(DataEventType.value) { (snapshot) in
            print("snap = \(snapshot)")
            var idKeys:[String]
            let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
            if eventDataloc.count > 0
            {
             print(eventDataloc.keys)
             for i in eventDataloc.keys
             {
              print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
              
              let depatObj = phase2Details(withdict: eventDataloc[i] as! [String : AnyObject] )
              print("DepatObj: \(depatObj)")
              userDetails.append(depatObj)
             }
             callback(userDetails as AnyObject, nil)
            }
            else
            {
             callback(eventDataloc as AnyObject, nil)
            }
            
            
           }
           
          }
    
    func getSynopsisReviewOne(callback: @escaping ResponseHandlerBlock)
    {
     let userdetails_ref = db.child("SynopsisAndPPT").child("Review 1")
     
     var userDetails:[synopsisDetails] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       print(eventDataloc.keys)
       for i in eventDataloc.keys
       {
        print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
        
        let depatObj = synopsisDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       }
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
     }
    }
    
    func getSynopsisReviewTwo(callback: @escaping ResponseHandlerBlock)
    {
     let userdetails_ref = db.child("SynopsisAndPPT").child("Review 2")
     
     var userDetails:[synopsisDetails] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       print(eventDataloc.keys)
       for i in eventDataloc.keys
       {
        print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
        
        let depatObj = synopsisDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       }
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
     }
    }
    
    func getSynopsisPhaseOne(callback: @escaping ResponseHandlerBlock)
    {
     let userdetails_ref = db.child("SynopsisAndPPT").child("Phase 1")
     
     var userDetails:[synopsisDetails] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       print(eventDataloc.keys)
       for i in eventDataloc.keys
       {
        print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
        
        let depatObj = synopsisDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       }
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
     }
    }
    
    func getSynopsisPhaseTwo(callback: @escaping ResponseHandlerBlock)
    {
     let userdetails_ref = db.child("SynopsisAndPPT").child("Phase 2")
     
     var userDetails:[synopsisDetails] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       print(eventDataloc.keys)
       for i in eventDataloc.keys
       {
        print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
        
        let depatObj = synopsisDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       }
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
     }
    }
    
    
 func getFacultyDetails(userId:String, callback: @escaping ResponseHandlerBlock)  {
          print("uid in clouser = \(userId)")
          
          let userdetails_ref = db.child("facultyDetails").child(userId)
          var userDetails:[allUserDetails] = []
            
            userDetails.removeAll()
            
            userdetails_ref.observe(DataEventType.value) { (snapshot) in
              print("snap = \(snapshot)")
              let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
              
              if eventDataloc.count > 0
              {

                      let depatObj = allUserDetails(withDictionary: eventDataloc )
                      
                      userDetails.append(depatObj)
                      
                      callback(userDetails as AnyObject, nil)
                      }
                      else
                      {
                          callback(eventDataloc as AnyObject, nil)
                      }
              }
    }
 
 func getNotificationDetails(userId:String, callback: @escaping ResponseHandlerBlock)
 {
  let userdetails_ref = db.child("Notification").child(userId)
  
  var userDetails:[notificationDetails] = []
  userDetails.removeAll()
  userdetails_ref.observe(DataEventType.value) { (snapshot) in
   print("snap = \(snapshot)")
   var idKeys:[String]
   let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
   if eventDataloc.count > 0
   {
    print(eventDataloc.keys)
    for i in eventDataloc.keys
    {
     print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
     
     let depatObj = notificationDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
     print("DepatObj: \(depatObj)")
     userDetails.append(depatObj)
    }
    callback(userDetails as AnyObject, nil)
   }
   else
   {
    callback(eventDataloc as AnyObject, nil)
   }
  }
}
 
    func getGrades(usn:String, callback: @escaping ResponseHandlerBlock)
    {
     let userdetails_ref = db.child("AcademicMarks").queryOrdered(byChild: usn)
     
     var userDetails:[academicMarks] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       print(eventDataloc.keys)
       for i in eventDataloc.keys
       {
        
        let depatObj = academicMarks(withdict: eventDataloc[i] as! [String : AnyObject] )
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       }
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
      
      
     }
     
     
    }
    
    func getDeadlineDates(callback: @escaping ResponseHandlerBlock)
    {
        let userdetails_ref = db.child("Deadlines").queryOrdered(byChild: "Phase")
     
     var userDetails:[deadline] = []
     userDetails.removeAll()
     
     userdetails_ref.observe(DataEventType.value) { (snapshot) in
      print("snap = \(snapshot)")
      var idKeys:[String]
      let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
      if eventDataloc.count > 0
      {
       print(eventDataloc.keys)
       for i in eventDataloc.keys
       {
        print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
        
        let depatObj = deadline(withdict: eventDataloc[i] as! [String : AnyObject] )
        print("DepatObj: \(depatObj)")
        userDetails.append(depatObj)
       }
       callback(userDetails as AnyObject, nil)
      }
      else
      {
       callback(eventDataloc as AnyObject, nil)
      }
      
      
     }
     
    }
 
    func getSlotDetails(phase:String, callback: @escaping ResponseHandlerBlock)
     {
      let userdetails_ref = db.child("SlotDetails").child(phase)
      
      var userDetails:[slotDetails] = []
      userDetails.removeAll()
      userdetails_ref.observe(DataEventType.value) { (snapshot) in
       print("snap = \(snapshot)")
       var idKeys:[String]
       let eventDataloc = snapshot.value as? [String: AnyObject] ?? [:]
       if eventDataloc.count > 0
       {
        print(eventDataloc.keys)
        for i in eventDataloc.keys
        {
         print("Eventdataloc: \(eventDataloc[i]!["Branch"])")
         
         let depatObj = slotDetails(withdict: eventDataloc[i] as! [String : AnyObject] )
         print("DepatObj: \(depatObj)")
         userDetails.append(depatObj)
        }
        callback(userDetails as AnyObject, nil)
       }
       else
       {
        callback(eventDataloc as AnyObject, nil)
       }
      }
    }
 
 /* func displayData()
  {   artDbRef = Database.database().reference().child("Artists")
  
  artDbRef.observe(DataEventType.value) { (snapshot) in
  if snapshot.childrenCount > 0
  {
  self.artists.removeAll()
  print(snapshot)
  for artists in snapshot.children.allObjects as! [DataSnapshot]
  {
  let artistsObj = artists.value as! [String:AnyObject]
  print("ArtistObj: \(artistsObj)")
  let artistName = artistsObj["artistName"]
  let artistGenre = artistsObj["Genre"]
  let artistMod = artistModel(artistId: artistsObj["id"] as! String,artistname: artistName as! String,  artistgenre: artistGenre as! String)
  self.artists.append(artistMod)
  }
  print(self.artists)
  }
  self.tableviewOutlet.reloadData()
  }
  
  }*/
}
