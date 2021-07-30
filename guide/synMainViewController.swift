import UIKit
import FirebaseAuth
import Firebase
class synMainViewController: UIViewController,UIPopoverPresentationControllerDelegate,getSynPhaseGuide,getSynGuideBatch {
    func getSelectedBatch(selectedBatch: String) {
     currBatch = Int(selectedBatch)!
     synBatch.setTitle(selectedBatch, for: .normal)
     fetchBatchData()
//     fetchSynopsisPhaseOne()
    }
    
    func getSelectedPhase(selectedPhase: String) {
     currPhase = selectedPhase
     synPhase.setTitle(selectedPhase, for: .normal)
        if (currPhase == "Review 1")
        {
            fetchSynopsisReviewOne()
        }
        else if (currPhase == "Review 2")
        {
            fetchSynopsisReviewTwo()
        }
        else if (currPhase == "Phase 1")
        {
            fetchSynopsisPhaseOne()
        }
        else
        {
            fetchSynopsisPhaseTwo()
        }
    }
    
    @IBAction func resetPassEmail(_ sender: UIButton) {
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
    
    @IBOutlet var synPhase: UIButton!
    @IBOutlet var synBatch: UIButton!
    @IBOutlet var item: UIBarButtonItem!
    
    var currBatch = 0
    var currPhase = ""
    var batchArray:[batchDetails] = []
    var usnList:[String] = []
    var listOfUsns:String = ""
    var idList:[String] = []
    var synDetail:[synopsisDetails] = []
    var notifyDetail:[notificationDetails] = []
    var studentDetail:[studentDetails] = []
    var notifications:[String] = []
    var notificationText:String = ""
    var titleProj = ""
    var abs = ""
    var dom = ""
    var lin = ""
    var presentBatch = 0
    var currID = ""
    var usnOne = ""
    var usnTwo = ""
    var usnThree = ""
    var usnFour = ""
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Guide id: \(guideId)")
        
        fetchNotification()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.23, green: 0.57, blue: 0.81, alpha: 1.00)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        print(notifications.count)
        self.custumbaritem(badgecount: "1")
        //self.custumbaritem(bardgecount: String(notifications.count))
        self.appDelegate!.scheduleNotification(notificationType: "Synopsis submission", body: notificationText)
                // Do any additional setup after loading the view.
    }
    
    @IBAction func synPhaseFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "next19") as! synPhaseViewController
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

    
    @IBAction func synBatchFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "next99") as! synBatchViewController
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
    
    @IBOutlet weak var projTitle: UILabel!
    @IBOutlet weak var teamMates: UILabel!
    @IBOutlet weak var domain: UILabel!
    @IBOutlet weak var abstract: UILabel!
    @IBOutlet weak var remarks: UITextField!
    
    @IBOutlet weak var viewPdf: UIButton!
    
    @IBAction func accept(_ sender: UIButton) {
        let db = Database.database().reference()
        let branch = db.child("SynopsisAndPPT").child(currPhase)
        let branchID = branch.child(currID)
        if remarks.text!.isEmpty {
         remarks.text = ""
        }
        
        branchID.updateChildValues(["GuideStatus":"Accepted","GuideRemarks":remarks.text,"ProgressSynGuide":1])
        
        saveNotification(text: "Accepted")
    }
    
    func saveNotification(text:String)
     {
      fetchIDs { (listIDs) in
       
      
       print("idList: \(self.idList)")
      
      let db = Database.database().reference()
      for i in listIDs
      {
       let ref = db.child("Notification").child(i)
       let refKey = ref.childByAutoId().key
       let refID = ref.child(refKey!)
       let data = ["Text":" \(self.currPhase) synopsis \(text) by guide","NotificationID":refKey]

       refID.setValue(data)
      }
    }
    }
    
    func fetchIDs(callback:@escaping ResponseHandlerBlock4)
    {
     fetchDetails().getAllStudentDetails { (studata, error) in
      if studata.count > 0
      {
       self.studentDetail = studata as! [studentDetails]
       if self.studentDetail.count > 0
       {
        for i in self.studentDetail
        {
         if i.batch == self.currBatch
         {
          self.idList.append(i.uid!)
         }
        }
       }
       callback(self.idList)
      }
     }
     
    }
    
    @IBAction func decline(_ sender: UIButton) {
        let db = Database.database().reference()
        let branch = db.child("SynopsisAndPPT").child(currPhase)
        let branchID = branch.child(currID)
        
        branchID.updateChildValues(["GuideStatus":"Declined","GuideRemarks":remarks.text,"ProgressSynGuide":0])
        
        saveNotification(text: "Declined")
    }
    
    func fetchBatchData()
    {
     fetchDetails().getBatchDetails { (batchData, error) in
      self.batchArray.removeAll()
      self.usnList.removeAll()
        self.listOfUsns.removeAll()
      if batchData.count > 0
      {
       // print(batchData.count)
       self.batchArray = batchData as! [batchDetails]
       print("batch array : \(self.batchArray)")
       if self.batchArray.count > 0
       {
        for i in self.batchArray
        {
         print(self.currBatch)
         if i.batchNumber == self.currBatch
         {
          self.usnList.append(i.usn1!)
          self.usnList.append(i.usn2!)
          self.usnList.append(i.usn3!)
          self.usnList.append(i.usn4!)
          print(self.usnList)
          self.listOfUsns.append(i.usn1! + " " + i.usn2! + " ")
          self.listOfUsns.append( i.usn3! + " " + i.usn4!)
          print(self.listOfUsns)
          self.teamMates.text = self.listOfUsns
            
            // To update progress
            self.usnOne = i.usn1!
            self.usnTwo = i.usn2!
            self.usnThree = i.usn3!
            self.usnFour = i.usn4!
         }
        }
       }
      }
     }
    }

    func fetchSynopsisReviewOne(){
     fetchDetails().getSynopsisReviewOne { (synData, error) in
      self.synDetail.removeAll()
      print("MarksData: \(synData)")
      if synData.count > 0
      {
       // print(batchData.count)
       self.synDetail = synData as! [synopsisDetails]
       
       print("Synopsis array : \(self.synDetail)")
       if self.synDetail.count > 0
       {
        for i in self.synDetail
        {
         print(self.currBatch)
         print(i.batchNum)
         var intBatch = Int(i.batchNum!)
         if intBatch == Int(self.currBatch)
         {print(" Cond satisfied")
          self.titleProj = i.projTitle!
          self.abs = i.abstract!
          self.dom = i.domain!
          self.lin = i.link!
          self.currID = i.uid!
         }
        }
       }
       print(self.lin)
       self.projTitle.text = self.titleProj
       self.abstract.text = self.abs
       self.domain.text = self.dom
      }
     }
     self.projTitle.text = self.titleProj
     self.abstract.text = self.abs
     self.domain.text = self.dom
    }
    
    func fetchSynopsisReviewTwo(){
     fetchDetails().getSynopsisReviewTwo { (synData, error) in
      self.synDetail.removeAll()
      print("MarksData: \(synData)")
      if synData.count > 0
      {
       // print(batchData.count)
       self.synDetail = synData as! [synopsisDetails]
       
       print("Synopsis array : \(self.synDetail)")
       if self.synDetail.count > 0
       {
        for i in self.synDetail
        {
         print(self.currBatch)
         print(i.batchNum)
         var intBatch = Int(i.batchNum!)
         if intBatch == Int(self.currBatch)
         {print(" Cond satisfied")
          self.titleProj = i.projTitle!
          self.abs = i.abstract!
          self.dom = i.domain!
          self.lin = i.link!
          self.currID = i.uid!
         }
        }
       }
       print(self.lin)
       self.projTitle.text = self.titleProj
       self.abstract.text = self.abs
       self.domain.text = self.dom
      }
     }
     self.projTitle.text = self.titleProj
     self.abstract.text = self.abs
     self.domain.text = self.dom
    }
    
    func fetchSynopsisPhaseOne(){
     fetchDetails().getSynopsisPhaseOne { (synData, error) in
      self.synDetail.removeAll()
      print("MarksData: \(synData)")
      if synData.count > 0
      {
       // print(batchData.count)
       self.synDetail = synData as! [synopsisDetails]
       
       print("Synopsis array : \(self.synDetail)")
       if self.synDetail.count > 0
       {
        for i in self.synDetail
        {
         print(self.currBatch)
         print(i.batchNum)
         var intBatch = Int(i.batchNum!)
         if intBatch == Int(self.currBatch)
         {print(" Cond satisfied")
          self.titleProj = i.projTitle!
          self.abs = i.abstract!
          self.dom = i.domain!
          self.lin = i.link!
          self.currID = i.uid!
         }
        }
       }
       print(self.lin)
       self.projTitle.text = self.titleProj
       self.abstract.text = self.abs
       self.domain.text = self.dom
      }
     }
     self.projTitle.text = self.titleProj
     self.abstract.text = self.abs
     self.domain.text = self.dom
    }
    
    func fetchSynopsisPhaseTwo(){
     fetchDetails().getSynopsisPhaseTwo { (synData, error) in
      self.synDetail.removeAll()
      print("MarksData: \(synData)")
      if synData.count > 0
      {
       // print(batchData.count)
       self.synDetail = synData as! [synopsisDetails]
       
       print("Synopsis array : \(self.synDetail)")
       if self.synDetail.count > 0
       {
        for i in self.synDetail
        {
         print(self.currBatch)
         print(i.batchNum)
         var intBatch = Int(i.batchNum!)
         if intBatch == Int(self.currBatch)
         {print(" Cond satisfied")
          self.titleProj = i.projTitle!
          
          self.abs = i.abstract!
          self.dom = i.domain!
          self.lin = i.link!
          self.currID = i.uid!
         }
        }
       }
       print(self.lin)
       self.projTitle.text = self.titleProj
       self.abstract.text = self.abs
       self.domain.text = self.dom
      }
     }
     self.projTitle.text = self.titleProj
     self.abstract.text = self.abs
     self.domain.text = self.dom
    }
    
    @objc func searchTapped(sender:UIButton)
         {
          
          print("tapped on notifcation icon")
          performSegue(withIdentifier: "toGNotificationDisplay", sender: self)
          
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
          
          
        //  self.custumbaritem(bardgecount: "1")
        //
        //  self.appDelegate!.scheduleNotification(notificationType: "Leave Application", body: "Please accept for the leave")

          
         }
         
         
         func fetchNotification()
         {
          fetchDetails().getNotificationDetails(userId: guideId) { (notifyData, error) in
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
        
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //      if segue.identifier == "toPdfView"
    //      {
    //      let destVC = segue.destination as! viewPDFViewController
    //      destVC.selPhase = self.currPhase
    //      destVC.selId = self.currID
    //      destVC.urlOfTheFile = self.lin
    //      }
          
          if segue.identifier == "toGNotificationDisplay"
          {
           let destVC = segue.destination as! gNotificationDisplayViewController
           destVC.notifyArray = self.notifications
          }
         }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    @IBOutlet var logoutBtn: UIButton!
    @IBAction func logoutFunc(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let dest = storyboard.instantiateViewController(withIdentifier: "Mainview") as! ViewController
//        dest.modalPresentationStyle = .fullScreen
//        self.present(dest, animated:true, completion:nil)
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

