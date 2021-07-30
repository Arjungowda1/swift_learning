import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import MobileCoreServices

class synBatchMainViewController: UIViewController,UINavigationControllerDelegate,UIPopoverPresentationControllerDelegate,getPhase,getDomain {
    func selectDomain(selectedDomain: String) {
     currDomain = selectedDomain
     synBatchDomain.setTitle(selectedDomain, for: .normal)
    }
    
    func getSelectedPhase(selectedPhase: String) {
     currPhase = selectedPhase
     synBatchPhase.setTitle(selectedPhase, for: .normal)
     fetchStatus()
       computeProgress{() -> () in
        print("hello")
        progressBar.setProgress(Float(progCompleted), animated: true)
       }
    }
    
    @IBAction func resetPasswordEmail(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: (Auth.auth().currentUser?.email)!) { error in
          if error == nil
          {
            let myEmail = String((Auth.auth().currentUser?.email)!)
            let alert = UIAlertController(title: "Done!", message: "Reset password link has been sent to \(myEmail)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true,completion: nil)
          }
        }
    }
    
    var file:String?
     var currBatch:Int = 0
     var currPhase = ""
     var currDomain = ""
     var batchNumberOfUser = 0
     var usnOfUser = ""
     var urlOfFile = ""
     var uidOfUser = ""
    var sectionOfUser = ""
    var idCoord = ""
    var idGuide = ""
    var currSection = ""
    var synDetail:[synopsisDetails] = []
     var studentArray:[studentDetails] = []
    var coordArray:[coordinatorDetails] = []
    var guideArray:[guideDetails2] = []
    var notifyDetail:[notificationDetails] = []
    var batchsecs:[guideDetails] = []
    var notifications:[String] = []
    
     var currProgressReview1 = 0
     var currProgressReview2 = 0
     var currPhase1 = 0
     var currPhase2 = 0
     var progCompleted = 0
    var r1synProgCoord = 0
     var r1synProgGuide = 0
    var r2synProgCoord = 0
    var r2synProgGuide = 0
     var p1synProgCoord = 0
     var p1synProgGuide = 0
    var p2synProgCoord = 0
    var p2synProgGuide = 0
    var synTotalr1 = 0
    var synTotalr2 = 0
      var synTotalp1 = 0
    var synTotalp2 = 0
     var coordStatus = ""
     var coordRemarks = ""
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    let progress = Progress(totalUnitCount: 4)
    
    @IBOutlet var synBatchPhase: UIButton!
    @IBOutlet var synBatchDomain: UIButton!
    @IBOutlet weak var projTitle: UITextField!
    @IBOutlet weak var batchNumber: UITextField!
    @IBOutlet weak var abstract: UITextField!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet var item: UIBarButtonItem!
    
    @IBAction func submit(_ sender: UIButton) {
        self.createData(fileUrl: urlOfFile)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
         navigationController?.navigationBar.isHidden = false
//             navigationController?.navigationBar.barTintColor = UIColor.blue
             fetchNotification()
        //     self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        //     navigationController?.navigationBar.barTintColor = UIColor(red: 0.23, green: 0.57, blue: 0.81, alpha: 1.00)
        //
        //     self.navigationController?.navigationBar.tintColor = UIColor.white
             print(notifications.count)
             self.custumbaritem(badgecount: "1")
             //self.custumbaritem(bardgecount: String(notifications.count))
             self.appDelegate!.scheduleNotification(notificationType: "Synopsis submission", body: "")
             
        
        batchNumber.text = String(batchNumberOfUser)
        batchNumber.isUserInteractionEnabled = false
        //Add Progress
             progressBar.progress = 0
        progress.completedUnitCount = 0
        fetchCoordinator()
        fetchGuide()
           
        //     computeProgress{() -> () in
        //      print("hello")
        //      progressBar.setProgress(Float(progCompleted), animated: true)
        //     }
        //self.progressView.setProgress(Float(self.progress.fractionCompleted), animated: true)
             
                 // fetchStatus()
        // Do any additional setup after loading the view.
    }
    @IBAction func synBatchPhaseFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "next40") as! synBatchPhaseViewController
        // popcontrol.spec = true
         //popcontrol.somestring = rows2[indexPath.row]
        popcontrol.delegate = self
         popcontrol.modalPresentationStyle = UIModalPresentationStyle.popover
         popcontrol.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
         popcontrol.preferredContentSize.height = 200
         popcontrol.preferredContentSize.width = 200
         popcontrol.popoverPresentationController?.delegate = self
         popcontrol.popoverPresentationController?.sourceView = sender
         popcontrol.popoverPresentationController?.sourceRect = sender.bounds
         self.present(popcontrol, animated: true, completion: nil)
    }
    @IBAction func synBatchDomainFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "next41") as! synBatchDomainViewController
        // popcontrol.spec = true
         //popcontrol.somestring = rows2[indexPath.row]
        popcontrol.delegate = self
         popcontrol.modalPresentationStyle = UIModalPresentationStyle.popover
         popcontrol.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
         popcontrol.preferredContentSize.height = 200
         popcontrol.preferredContentSize.width = 200
         popcontrol.popoverPresentationController?.delegate = self
         popcontrol.popoverPresentationController?.sourceView = sender
         popcontrol.popoverPresentationController?.sourceRect = sender.bounds
         self.present(popcontrol, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var remarks: UILabel!
    @IBOutlet weak var gStatus: UILabel!
    @IBOutlet weak var gRemarks: UILabel!
    
    func createData(fileUrl:String)
    {
     let db = Database.database().reference()
     // print("the db = \(db)")
     //print(userId!)
     let parent = db.child("SynopsisAndPPT").child(currPhase)
     let childData = parent.childByAutoId().key
     let childId = parent.child(childData!)
     print(abstract.text)
        let data = ["Batch":batchNumber.text,"Domain":currDomain, "SynopsisPPT":fileUrl,"Abstract":abstract.text,"ProjectTitle": projTitle.text,"Section":currSection,"ID":childData] as [String:Any]
     childId.setValue(data)
     print("File uploaded")
        saveNotification()
    }
    
//    func p1FetchProg()
//    {
//        fetchDetails().getSynopsisPhaseOne { (synData, error) in
//          self.synDetail.removeAll()
//            print("kkkk")
//            print(synData)
//          if synData.count > 0
//          {
//           // print(batchData.count)
//           self.synDetail = synData as! [synopsisDetails]
//          }
//         }
//        print("ffff")
//        print(synDetail.count)
//        print(synDetail)
//
//        print("Synopsis array : \(self.synDetail)")
//               if self.synDetail.count > 0
//               {
//                for i in self.synDetail
//                {
//                 print(self.batchNumberOfUser)
//                 print(i.batchNum)
//                 var intBatch = Int(i.batchNum!)
//                 if intBatch == Int(self.batchNumberOfUser)
//                 {print(" Cond satisfied")
//
//                  self.p1synProgCoord = i.progressSynCoord!
//                    print("cooooooord : \(self.p1synProgCoord)")
//                  self.p1synProgGuide = i.progressSynGuide!
//                 }
//                }
//               }
//    }
//
//    func p2FetchProg()
//    {
//        fetchDetails().getSynopsisPhaseTwo { (synData, error) in
//          self.synDetail.removeAll()
//          if synData.count > 0
//          {
//           // print(batchData.count)
//           self.synDetail = synData as! [synopsisDetails]
//          }
//         }
//        print("Synopsis array : \(self.synDetail)")
//               if self.synDetail.count > 0
//               {
//                for i in self.synDetail
//                {
//                 print(self.batchNumberOfUser)
//                 print(i.batchNum)
//                 var intBatch = Int(i.batchNum!)
//                 if intBatch == Int(self.batchNumberOfUser)
//                 {print(" Cond satisfied")
//
//                  self.p2synProgCoord = i.progressSynCoord!
//                  self.p2synProgGuide = i.progressSynGuide!
//                 }
//                }
//               }
//    }
    
    func fetchStatus()
        {
            if(currPhase == "Review 1")
            {
                  fetchDetails().getSynopsisReviewOne { (synData, error) in
                   self.synDetail.removeAll()
                   if synData.count > 0
                   {
                    // print(batchData.count)
                    self.synDetail = synData as! [synopsisDetails]
                   }
                  }
                 print("Synopsis array : \(self.synDetail)")
                        if self.synDetail.count > 0
                        {
                         for i in self.synDetail
                         {
                          print(self.batchNumberOfUser)
                          print(i.batchNum)
                          var intBatch = Int(i.batchNum!)
                          if intBatch == Int(self.batchNumberOfUser)
                          {print(" Cond satisfied")
                           self.coordStatus = i.coordinatorStatus!
                           
                           self.coordRemarks = i.coordinatorRemarks!
                           
                           self.r1synProgCoord = i.progressSynCoord!
                           self.r1synProgGuide = i.progressSynGuide!
                           self.gStatus.text = i.guideStatus
                           self.gRemarks.text = i.guideRemarks
                          }
                         }
                        }
                        self.status.text = self.coordStatus
                        self.remarks.text = self.coordRemarks
                }
                else if(currPhase == "Review 2")
                {
                      fetchDetails().getSynopsisReviewTwo { (synData, error) in
                       self.synDetail.removeAll()
                       if synData.count > 0
                       {
                        // print(batchData.count)
                        self.synDetail = synData as! [synopsisDetails]
                       }
                      }
                     print("Synopsis array : \(self.synDetail)")
                            if self.synDetail.count > 0
                            {
                             for i in self.synDetail
                             {
                              print(self.batchNumberOfUser)
                              print(i.batchNum)
                              var intBatch = Int(i.batchNum!)
                              if intBatch == Int(self.batchNumberOfUser)
                              {print(" Cond satisfied")
                               self.coordStatus = i.coordinatorStatus!
                               
                               self.coordRemarks = i.coordinatorRemarks!
                               
                               self.r2synProgCoord = i.progressSynCoord!
                               self.r2synProgGuide = i.progressSynGuide!
                               self.gStatus.text = i.guideStatus
                               self.gRemarks.text = i.guideRemarks
                              }
                             }
                            }
                            self.status.text = self.coordStatus
                            self.remarks.text = self.coordRemarks
                    }
                    else if(currPhase == "Phase 1")
                    {
                 fetchDetails().getSynopsisPhaseOne { (synData, error) in
                  self.synDetail.removeAll()
                  if synData.count > 0
                  {
                   // print(batchData.count)
                   self.synDetail = synData as! [synopsisDetails]
                  }
                 }
                print("Synopsis array : \(self.synDetail)")
                       if self.synDetail.count > 0
                       {
                        for i in self.synDetail
                        {
                         print(self.batchNumberOfUser)
                         print(i.batchNum)
                         var intBatch = Int(i.batchNum!)
                         if intBatch == Int(self.batchNumberOfUser)
                         {print(" Cond satisfied")
                          self.coordStatus = i.coordinatorStatus!
                          
                          self.coordRemarks = i.coordinatorRemarks!
                          
                          self.p1synProgCoord = i.progressSynCoord!
                          self.p1synProgGuide = i.progressSynGuide!
                          self.gStatus.text = i.guideStatus
                          self.gRemarks.text = i.guideRemarks
                         }
                        }
                       }
                       self.status.text = self.coordStatus
                       self.remarks.text = self.coordRemarks
           }
            else
            {
                fetchDetails().getSynopsisPhaseTwo { (synData, error) in
                 self.synDetail.removeAll()
                 if synData.count > 0
                 {
                  // print(batchData.count)
                  self.synDetail = synData as! [synopsisDetails]
                 }
                }
                print("Synopsis array : \(self.synDetail)")
                       if self.synDetail.count > 0
                       {
                        for i in self.synDetail
                        {
                         print(self.batchNumberOfUser)
                         print(i.batchNum)
                         var intBatch = Int(i.batchNum!)
                         if intBatch == Int(self.batchNumberOfUser)
                         {print(" Cond satisfied")
                          self.coordStatus = i.coordinatorStatus!
                          
                          self.coordRemarks = i.coordinatorRemarks!
                          
                          self.p2synProgCoord = i.progressSynCoord!
                          self.p2synProgGuide = i.progressSynGuide!
                          self.gStatus.text = i.guideStatus
                          self.gRemarks.text = i.guideRemarks
                          
                     
                         }
                        }
                       }
                       self.status.text = self.coordStatus
                       self.remarks.text = self.coordRemarks
            }
     }
     // fetch progress
     func computeProgress(completion: () -> ())
     {
            
        fetchProgressData{(currProRev1,currProRev2,currProPhase1,currProPhase2 ) in
            
        self.synTotalr1 = self.r1synProgCoord + self.r1synProgGuide
        if currProRev1 == 3 && self.synTotalr1 == 2
        {
            self.progCompleted = 1
        }
        self.synTotalr2 = self.r2synProgCoord + self.r2synProgGuide
        if currProRev2 == 3 && self.synTotalr2 == 2
        {
            self.progCompleted = 2
        }
//        self.p1FetchProg()
//        self.p2FetchProg()
        self.synTotalp1 = self.p1synProgCoord + self.p1synProgGuide
       if currProPhase1 == 3 && self.synTotalp1 == 2
       {
        self.progCompleted = 3
       }
        self.synTotalp2 = self.p2synProgCoord + self.p2synProgGuide
        if currProPhase2 == 3 && self.synTotalp2 == 2
     {self.progCompleted = 4
       }
       switch self.progCompleted
    {
        case 4 : self.progress.completedUnitCount = 4
        
        

        case 3:
         self.progress.completedUnitCount = 3
        case 2:
         self.progress.completedUnitCount = 2
        
            case 1:
         self.progress.completedUnitCount = 1

        default:
        break
       }
       self.progressBar.setProgress(Float(self.progress.fractionCompleted), animated: true)
      }
      
     }
    
     func fetchProgressData(callback:@escaping ResponseHandlerBlock2)
     {
      fetchDetails().getAllStudentDetails { (stuData, error) in
       if stuData.count > 0
       {
        
        self.studentArray = stuData as! [studentDetails]
        // print("student array : \(self.studentArray)")
        if self.studentArray.count > 0
        {
         for i in self.studentArray
         { print(i.batch)
          if (i.batch == self.batchNumberOfUser) && i.usn == self.usnOfUser
          {
           self.currProgressReview1 = i.progressReview1!
           self.currProgressReview2 = i.progressReview2!
           self.currPhase1 = i.progressPhase1!
           self.currPhase2 = i.progressPhase2!
           
          }
          // print(i.name)
         }
        }
        callback(self.currProgressReview1, self.currProgressReview2, self.currPhase1, self.currPhase2)   }
      }
     }
     
     func progressSynopsis(callback:@escaping ResponseHandlerBlock3)
     {
      fetchDetails().getSynopsisPhaseOne { (synData, error) in
       if synData.count > 0
       {
        
       }
      }
     }

    func fetchCoordinator()
    {
     fetchDetails().getAllCoordinatorDetails{ (coordData, error) in
      if coordData.count > 0{
       self.coordArray = coordData as! [coordinatorDetails]
       
       if self.coordArray.count > 0
       {
        for i in self.coordArray
        {
         if i.section == self.sectionOfUser
         {
          self.idCoord = i.uid!
            self.currSection = i.section!
         }
        }
        
       }
      }
     }
    }
    
    func fetchGuide()
    {
     fetchDetails().getAllGuideDetails{ (guideData, error) in
      if guideData.count > 0{
       self.guideArray = guideData as! [guideDetails2]
        print("mmmm : \(self.guideArray)")
       if self.guideArray.count > 0
       {
        for i in self.guideArray
        { fetchDetails().getGuideBatches(userId: i.uid!, callback: { (batchData, error) in
                self.batchsecs = batchData as! [guideDetails]
                for j in self.batchsecs
                {
                    if j.section == self.sectionOfUser
                    {
                        self.idGuide = i.uid!
                    }
                }
                
            })
         
        }
        
       }
      }
     }
    }
    
    func saveNotification(){
     print(self.idCoord)
     let db = Database.database().reference()
     let ref = db.child("Notification").child(idCoord)
     let refKey = ref.childByAutoId().key
     let refID = ref.child(refKey!)
     let data = ["Text":"Batch \(batchNumberOfUser) - \(currPhase) synopsis submitted","NotificationID":refKey]
     refID.setValue(data)
     print("cccc : \(idGuide)")
    let ref2 = db.child("Notification").child(idGuide)
    let refKey2 = ref2.childByAutoId().key
    let refID2 = ref2.child(refKey2!)
    let data2 = ["Text":"Batch \(batchNumberOfUser) - \(currPhase) synopsis submitted","NotificationID":refKey2]
    refID2.setValue(data2)
    }
    
    func fetchNotification()
    {
     fetchDetails().getNotificationDetails(userId: uidOfUser) { (notifyData, error) in
      if notifyData.count > 0
      {
       self.notifyDetail = notifyData as! [notificationDetails]
       if (self.notifyDetail.count > 0)
       {
        for i in self.notifyDetail
        {
         print("Notification: \(i.text)")
         // self.notificationText = i.text!
         self.notifications.append(i.text!)
         
        }
       }
      }
     }
    }
    
    @objc func searchTapped(sender:UIButton)
    {
     
     print("tapped on notifcation icon")
     performSegue(withIdentifier: "toNotificationDisplay", sender: self)
     
    }
    
    func custumbaritem(badgecount:String)
    {
     let notificationButton = SSBadgeButton()
     notificationButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
     notificationButton.setImage(UIImage(named: "notification")?.withRenderingMode(.alwaysTemplate), for: .normal)
     notificationButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
     
     //time being
     //  notificationButton.badge = nil
     
     if badgecount == "0"
     {
      //                   self.hideActivityIndicator()
      notificationButton.badge = nil
     }
     else
     {
      //                   self.hideActivityIndicator()
      notificationButton.badge = badgecount
     }
     print(notificationButton)
     item = UIBarButtonItem(customView: notificationButton)
     //notifyButton = UIBarButtonItem(customView: notificationButton)
     
     // self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView:notificationButton)]
     item.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchTapped)))
     
     self.navigationItem.setRightBarButtonItems([item], animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     if segue.identifier == "toPdfView"
//     {
//     let destVC = segue.destination as! viewPDFViewController
//     destVC.selPhase = self.currPhase
//     destVC.selId = self.currID
//     destVC.urlOfTheFile = self.lin
//     }
     
     if segue.identifier == "toNotificationDisplay"
     {
      let destVC = segue.destination as! NotifyViewController
      destVC.notifyArray = self.notifications
     }
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    @IBOutlet var logoutBtn: UIButton!
    @IBAction func logout(_ sender: UIButton) {
        do
          {
              try Auth.auth().signOut()
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let IntroVC = storyboard.instantiateViewController(withIdentifier: "Mainview") as! ViewController
              let appDelegate = UIApplication.shared.delegate as! AppDelegate
              appDelegate.window?.rootViewController = IntroVC
          }
          catch let error as NSError
          {
              print(error.localizedDescription)
          }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
