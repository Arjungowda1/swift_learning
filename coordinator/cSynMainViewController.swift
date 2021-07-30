//
//  cSynMainViewController.swift
//  trackPro
//
//  Created by IOSLevel01 on 08/06/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class cSynMainViewController: UIViewController,UIPopoverPresentationControllerDelegate,getval_splcSyn2,getval_splcSyn3 {
    
   func getSelectedPhase(selectedPhase: String) {
     currPhase = selectedPhase
     cSynPhase.setTitle(selectedPhase, for: .normal)
    if(currPhase == "Review 1")
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
    
    func getSelectedBatch(selectedBatch: String) {
     currBatch = Int(selectedBatch)!
     cSynBatch.setTitle(selectedBatch, for: .normal)
     fetchBatchData()
//     fetchSynopsisPhaseOne()
    }
    
    @IBAction func resetPass(_ sender: UIButton) {
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
    
    @IBOutlet var cSynBatch: UIButton!
    @IBOutlet var cSynPhase: UIButton!
    
    @IBOutlet var item: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Coordinator id: \(coordinatorId)")
        
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
  
    
    @IBAction func cSynBatchFunc(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "cSynBatch") as! cSynBatchViewController
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
    
    @IBAction func cSynPhaseFunc(_ sender: UIButton) {
       let popcontrol =  self.storyboard?.instantiateViewController(withIdentifier: "cSynPhase") as! cSynPhaseViewController
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
          //self.idList.append(i.uid)
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

    
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var teamMates: UILabel!
    @IBOutlet weak var domain: UILabel!
    @IBOutlet weak var abstract: UILabel!
    @IBOutlet weak var remarks: UITextField!
    
    func fetchSynopsisReviewOne()
    {
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
        self.projectTitle.text = self.titleProj
        self.abstract.text = self.abs
        self.domain.text = self.dom
       }
      }
      
      self.projectTitle.text = self.titleProj
      self.abstract.text = self.abs
      self.domain.text = self.dom
    }
    
    func fetchSynopsisReviewTwo()
    {
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
            self.projectTitle.text = self.titleProj
            self.abstract.text = self.abs
            self.domain.text = self.dom
           }
          }
          
          self.projectTitle.text = self.titleProj
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
        self.projectTitle.text = self.titleProj
        self.abstract.text = self.abs
        self.domain.text = self.dom
       }
      }
      
      self.projectTitle.text = self.titleProj
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
        self.projectTitle.text = self.titleProj
        self.abstract.text = self.abs
        self.domain.text = self.dom
       }
      }
      self.projectTitle.text = self.titleProj
      self.abstract.text = self.abs
      self.domain.text = self.dom
     }
    
    @IBAction func accept(_ sender: UIButton) {
        let db = Database.database().reference()
        let branch = db.child("SynopsisAndPPT").child(currPhase)
        let branchID = branch.child(currID)
        if remarks.text!.isEmpty {
         remarks.text = ""
        }
        
        branchID.updateChildValues(["CoordStatus":"Accepted","CoordRemarks":remarks.text,"ProgressSynCoord":1])
        
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
       let data = ["Text":" \(self.currPhase) synopsis \(text) by coordinator","NotificationID":refKey]

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
        
        branchID.updateChildValues(["CoordStatus":"Declined","CoordRemarks":remarks.text,"ProgressSynCoord":0])
        saveNotification(text: "Declined")
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
      
      
    //  self.custumbaritem(bardgecount: "1")
    //
    //  self.appDelegate!.scheduleNotification(notificationType: "Leave Application", body: "Please accept for the leave")

      
     }
     
     
     func fetchNotification()
     {
      fetchDetails().getNotificationDetails(userId: coordinatorId) { (notifyData, error) in
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
      
      if segue.identifier == "toNotificationDisplay"
      {
       let destVC = segue.destination as! notificationDisplayViewController
       destVC.notifyArray = self.notifications
      }
     }

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
    /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }
    class SSBadgeButton: UIButton {
     
     var badgeLabel = UILabel()
     
     var badge: String? {
      didSet {
       addBadgeToButon(badge: badge)
      }
     }
     
     public var badgeBackgroundColor = UIColor.red {
      didSet {
       badgeLabel.backgroundColor = badgeBackgroundColor
      }
     }
     
     public var badgeTextColor = UIColor.white {
      didSet {
       badgeLabel.textColor = badgeTextColor
      }
     }
     
     public var badgeFont = UIFont.systemFont(ofSize: 12.0) {
      //12.0
      didSet {
       badgeLabel.font = badgeFont
       
      }
     }
     
     public var badgeEdgeInsets: UIEdgeInsets? {
      didSet {
       addBadgeToButon(badge: badge)
      }
     }
     
     override init(frame: CGRect) {
      super.init(frame: frame)
      addBadgeToButon(badge: nil)
     }
        
        func addBadgeToButon(badge: String?) {
         badgeLabel.text = badge
         badgeLabel.textColor = badgeTextColor
         badgeLabel.backgroundColor = badgeBackgroundColor
         badgeLabel.font = badgeFont
         badgeLabel.sizeToFit()
         badgeLabel.textAlignment = .center
         let badgeSize = badgeLabel.frame.size
         
         let height = max(18, Double(badgeSize.height) + 5.0)
         let width = max(height, Double(badgeSize.width) + 10.0)
         
         var vertical: Double?, horizontal: Double?
         if let badgeInset = self.badgeEdgeInsets {
          vertical = Double(badgeInset.top) - Double(badgeInset.bottom)
          horizontal = Double(badgeInset.left) - Double(badgeInset.right)
          
          let x = (Double(bounds.size.width) - 10 + horizontal!)
          let y = -(Double(badgeSize.height) / 2) - 10 + vertical!
          badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
         } else {
          let x = self.frame.width - CGFloat((width / 2.0))
          let y = CGFloat(-(height / 2.0))
          badgeLabel.frame = CGRect(x: x, y: y, width: CGFloat(width), height: CGFloat(height))
         }
         
         badgeLabel.layer.cornerRadius = badgeLabel.frame.height/2
         badgeLabel.layer.masksToBounds = true
         addSubview(badgeLabel)
         badgeLabel.isHidden = badge != nil ? false : true
        }
        
        required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         self.addBadgeToButon(badge: nil)
         fatalError("init(coder:) has not been implemented")
        }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
        

    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
