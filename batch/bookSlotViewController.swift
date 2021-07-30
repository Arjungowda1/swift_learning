//
//  bookSlotViewController.swift
//  trackPro
//
//  Created by iOSLevel1 on 16/07/20.
//  Copyright © 2020 creative. All rights reserved.
//

import UIKit
import Firebase
class bookSlotViewController: UIViewController,UIPopoverPresentationControllerDelegate,getPhase {
    func getSelectedPhase(selectedPhase: String) {
     currPhase = selectedPhase
     synBatchPhase.setTitle(selectedPhase, for: .normal)
        fetchBatch()
     fetchDeadlineDate()
        if self.deadline == ""
        {
            self.deadlineMessage.text = "The deadline for \(currPhase) is not yet set."
        }
        else
        {
            self.deadlineMessage.text = "The deadline for \(currPhase) is : \(deadDate). Pick a date before that."
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var currPhase = ""
    var currBatch = 0
    var deadline = ""
    var dateStr1 = ""
    var dateStrFinal = ""
    var deadDate = Date()
    var myDate1 = Date()
    var dateFinal = Date()
    var deadlineDates:[deadline] = []
    var slotDetailsArr:[slotDetails] = []
    var slotDetailsArr2:[slotDetails] = []
    var studentArray:[studentDetails] = []
    
    @IBOutlet weak var myDate: UIDatePicker!
    @IBOutlet weak var synBatchPhase: UIButton!
    @IBOutlet weak var deadlineMessage: UILabel!
    
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
    
    func fetchDeadlineDate()
    {
        fetchDetails().getDeadlineDates { (stuData, error) in
            self.deadline.removeAll()
            self.deadlineDates.removeAll()
            if stuData.count > 0
            {
                self.deadlineDates = stuData as! [deadline]
                if self.deadlineDates.count > 0
                {
                    for i in self.deadlineDates
                    {
                        if i.phase == self.currPhase
                        {
                            self.deadline = i.deadlineDate!
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy"
                            self.deadDate = dateFormatter.date(from: i.deadlineDate!)!
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func submit(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.dateStrFinal = dateFormatter.string(from: self.myDate!.date)
        self.dateFinal = dateFormatter.date(from: self.dateStrFinal)!
        print("bzz : \(self.dateStrFinal)")
        dateFormatter.dateFormat = "dd-MM-yyyy"
        //uidatepicker() to string
        self.dateStr1 = dateFormatter.string(from: self.myDate!.date)
        print("bzz : \(self.dateStr1)")
        //string to Date()
        self.myDate1 = dateFormatter.date(from: dateStr1)!
        if self.myDate1 > self.deadDate
        {
            let alert = UIAlertController(title: "Error!", message: "Please choose a date before the deadline : \(self.deadDate)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true,completion: nil)
        }
        else
        {
            
            fetchSlotDetails()
            validateDate()
        }
    }
    
    func validateDate()
    {
        for k in self.slotDetailsArr
        {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let d = df.date(from: k.deadlineDate!)
            let dplus60 = d!.addingTimeInterval(3600)
            let dplus0 = d!.addingTimeInterval(0)
            print("plus60: \(dplus0)")
            if self.dateFinal <= dplus60 && self.dateFinal >= dplus0
            {
                let alert = UIAlertController(title: "Error!", message: "The slot has been taken already! Please choose another slot.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true,completion: nil)
                return
            }
        }
        
            let db = Database.database().reference()
            let ref = db.child("SlotDetails").child(currPhase)
            let refKey = ref.childByAutoId().key
            let refID = ref.child(refKey!)
            let data = ["DeadlineDate":self.dateStrFinal,"Batch":currBatch ,"deadlineID":refKey] as [String : Any]

            refID.setValue(data)
            let alert = UIAlertController(title: "Success!", message: "Your slot is : \(self.dateStrFinal)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true,completion: nil)
        
    }
    
    func fetchSlotDetails()
    {
        fetchDetails().getSlotDetails(phase: currPhase) { (slotData, error) in
            self.slotDetailsArr2.removeAll()
            self.slotDetailsArr.removeAll()
         if slotData.count > 0
         {
          self.slotDetailsArr2 = slotData as! [slotDetails]
          if (self.slotDetailsArr2.count > 0)
          {
           for i in self.slotDetailsArr2
           {
            self.slotDetailsArr.append(i)
            
           }
          }
         }
        }
    }
    
    func fetchBatch()
    {
     fetchDetails().getAllStudentDetails { (stuData, error) in
       self.studentArray.removeAll()
      if stuData.count > 0
      {
       self.studentArray = stuData as! [studentDetails]
      // print("student array : \(self.studentArray)")
       if self.studentArray.count > 0
       {
           for i in 0...(self.studentArray.count - 1)
           {
            if self.studentArray[i].uid == Auth.auth().currentUser?.uid
               {
                self.currBatch = self.studentArray[i].batch!
               }
           }
       }
      // self.createBatchTableView.reloadData()
      }
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
