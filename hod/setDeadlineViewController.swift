//
//  setDeadlineViewController.swift
//  trackPro
//
//  Created by iOSLevel1 on 14/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase
class setDeadlineViewController: UIViewController,UIPopoverPresentationControllerDelegate,sdGetPhase {
    func getSelectedPhase(selectedPhase: String) {
        selectPhase.setTitle(selectedPhase, for: .normal)
        currPhase = selectedPhase
    }
    
    var currPhase = ""
    var deadDate = ""
    var studentDetail:[studentDetails] = []
    var coordDetail:[coordinatorDetails] = []
    var guideDetail:[guideDetails2] = []
    var studentsIDList:[String] = []
    var coordsIDList:[String] = []
    var guideIDList:[String] = []
    
    @IBOutlet weak var selectPhase: UIButton!
    
    @IBAction func selectedPhase(_ sender: UIButton) {
        let popcontrol = self.storyboard?.instantiateViewController(withIdentifier: "phaseSelection3") as! sdPhaseViewController
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
    
    @IBAction func submit(_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        self.deadDate = formatter.string(from: deadline.date)
        saveNotification(deadlineDate: deadDate)
        saveDeadline(phase: self.currPhase, date: self.deadDate)
    }
    func saveDeadline(phase:String, date:String)
    {
        let db = Database.database().reference()
        let ref = db.child("Deadlines")   
        let refKey = ref.childByAutoId().key
        let refID = ref.child(refKey!)
        let data = ["Phase":phase,"DeadlineDate":date ,"deadlineID":refKey] as [String : Any]
        refID.setValue(data)
    }
    @IBOutlet weak var deadline: UIDatePicker!
    func saveNotification(deadlineDate:String)
    {
        fetchStudentIDs { (listIDs) in
            let db = Database.database().reference()
            for i in listIDs
            {
             let ref = db.child("Notification").child(i)
             let refKey = ref.childByAutoId().key
             let refID = ref.child(refKey!)
             let data = ["Text":"Deadline for \(self.currPhase) is \(deadlineDate)","NotificationID":refKey]
             refID.setValue(data)
            }
        }
        fetchCoordIDs { (listIDs) in
            let db = Database.database().reference()
            for i in listIDs
            {
             let ref = db.child("Notification").child(i)
             let refKey = ref.childByAutoId().key
             let refID = ref.child(refKey!)
             let data = ["Text":"Deadline for \(self.currPhase) is \(deadlineDate)","NotificationID":refKey]
             refID.setValue(data)
            }
        }
        fetchGuideIDs { (listIDs) in
            let db = Database.database().reference()
            for i in listIDs
            {
             let ref = db.child("Notification").child(i)
             let refKey = ref.childByAutoId().key
             let refID = ref.child(refKey!)
             let data = ["Text":"Deadline for \(self.currPhase) is \(deadlineDate)","NotificationID":refKey]
             refID.setValue(data)
            }
        }
    }
    
    func fetchStudentIDs(callback:@escaping ResponseHandlerBlock4)
    {
     fetchDetails().getAllStudentDetails { (studata, error) in
      if studata.count > 0
      {
       self.studentDetail = studata as! [studentDetails]
       if self.studentDetail.count > 0
       {
        for i in self.studentDetail
        {
         
          self.studentsIDList.append(i.uid!)
         
        }
       }
       callback(self.studentsIDList)
      }
     }
     
    }
    
     func fetchCoordIDs(callback:@escaping ResponseHandlerBlock4)
    {
     fetchDetails().getAllCoordinatorDetails { (coodata, error) in
      if coodata.count > 0
      {
       self.coordDetail = coodata as! [coordinatorDetails]
       if self.coordDetail.count > 0
       {
        for i in self.coordDetail
        {
         
          self.coordsIDList.append(i.uid!)
         
        }
       }
       callback(self.coordsIDList)
      }
     }
    }
    
    func fetchGuideIDs(callback:@escaping ResponseHandlerBlock4)
    {
     fetchDetails().getAllGuideDetails { (coodata, error) in
      if coodata.count > 0
      {
       self.guideDetail = coodata as! [guideDetails2]
       if self.guideDetail.count > 0
       {
        for i in self.guideDetail
        {
         
          self.guideIDList.append(i.uid!)
         
        }
       }
       callback(self.guideIDList)
      }
     }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
